/*
 * Copyright (C) 2010-2011 NVIDIA, Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 * 02111-1307, USA
 */
#include <linux/i2c.h>
#include <linux/pda_power.h>
#include <linux/platform_device.h>
#include <linux/resource.h>
#include <linux/regulator/machine.h>
#include <linux/mfd/max8907c.h>
#include <linux/power/max8907c-charger.h>
#include <linux/regulator/max8907c-regulator.h>
#include <linux/regulator/max8952n1.h>
#include <linux/max17043_battery.h>
#include <linux/gpio.h>
#include <linux/io.h>
#include <linux/power_supply.h>
#include <linux/irq.h>
#include <linux/interrupt.h>
#include <mach/sec_battery.h>
#include <mach/iomap.h>
#include <mach/irqs.h>

#include "gpio-names.h"
#include "fuse.h"
#include "pm.h"

#include "wakeups-t2.h"
#include "board.h"

#define PMC_CTRL		0x0
#define PMC_CTRL_INTR_LOW	(1 << 17)

static int ac_ok		= TEGRA_GPIO_PV3;
static int charge_disable	= TEGRA_GPIO_PR6;

static int charge_init(struct device *dev)
{
	int ret = gpio_request(charge_disable, "chg_disable");
	if (ret < 0)
		return ret;

	ret = gpio_request(ac_ok, "ac_ok");
	if (ret < 0) {
		gpio_free(charge_disable);
		return ret;
	}

	ret = gpio_direction_output(charge_disable, 0);
	if (ret < 0)
		goto cleanup;

	ret = gpio_direction_input(ac_ok);
	if (ret < 0)
		goto cleanup;

	tegra_gpio_enable(ac_ok);
	tegra_gpio_enable(charge_disable);

	return 0;

cleanup:
	gpio_free(ac_ok);
	gpio_free(charge_disable);
	return ret;
}

static void charge_exit(struct device *dev)
{
	gpio_free(charge_disable);
}

static int ac_online(void)
{
	return !gpio_get_value(ac_ok);
}

static void set_charge(int flags)
{
	if (flags == PDA_POWER_CHARGE_AC)
		gpio_set_value(charge_disable, 0);
	else if (!flags)
		gpio_set_value(charge_disable, 1);
	/* USB charging not supported on Ventana */
}

extern enum cable_type_t set_cable_status;
static int max8907c_power_vchg_f_cb(int vdcin)
{
	struct power_supply *psy = power_supply_get_by_name("battery");
	union power_supply_propval value;

	if(set_cable_status == CABLE_TYPE_DOCK) {
		set_cable_status = CABLE_TYPE_NONE;
		value.intval = POWER_SUPPLY_TYPE_BATTERY;

		if (!psy) {
			pr_err("%s: fail to get battery ps\n", __func__);
			return -1;
		}

		psy->set_property(psy, POWER_SUPPLY_PROP_ONLINE, &value);
	}
	return 0;
}

/* FACTORY TEST BINARY */
static int max8907c_power_vchg_r_f_cb(int vchg_on)
{
	struct power_supply *psy = power_supply_get_by_name("battery");
	union power_supply_propval value;

	if (vchg_on ) {
		set_cable_status = CABLE_TYPE_AC;
		value.intval = POWER_SUPPLY_TYPE_MAINS;
	}else {
		set_cable_status = CABLE_TYPE_NONE;
		value.intval = POWER_SUPPLY_TYPE_BATTERY;
	}

	if (!psy) {
		pr_err("%s: fail to get battery ps\n", __func__);
		return -ENODEV;
	}

	psy->set_property(psy, POWER_SUPPLY_PROP_ONLINE, &value);

	return 0;
}

static int max8907c_power_topoff_cb(void)
{
	struct power_supply *psy = power_supply_get_by_name("battery");
	union power_supply_propval value;

	if (!psy) {
		pr_err("%s: Max8907c-Charger : Fail to get battery ps\n", __func__);
		return -ENODEV;
	}

	value.intval = POWER_SUPPLY_STATUS_FULL;
	return psy->set_property(psy, POWER_SUPPLY_PROP_STATUS, &value);
}

static struct resource n1_pda_resources[] = {
	[0] = {
		.name	= "ac",
		.start	= TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_PV3),
		.end	= TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_PV3),
		.flags	= (IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
			   IORESOURCE_IRQ_LOWEDGE),
	},
};

static struct pda_power_pdata n1_pda_data = {
	.is_ac_online	= ac_online,
	.exit		= charge_exit,
	.init		= charge_init,
	.set_charge	= set_charge,
};

static struct platform_device n1_pda_power_device = {
	.name		= "pda-power",
	.id		= -1,
	.resource	= n1_pda_resources,
	.num_resources	= ARRAY_SIZE(n1_pda_resources),
	.dev	= {
		.platform_data	= &n1_pda_data,
	},
};

static struct max8907c_charger_pdata n1_charger_pdata = {
	.irq 			= INT_EXTERNAL_PMU,
    .topoff_cb = max8907c_power_topoff_cb,
    .vchg_f_cb = max8907c_power_vchg_f_cb,
    .vchg_r_f_cb = max8907c_power_vchg_r_f_cb, /* FACTORY TEST BINARY */
	.topoff_threshold	= MAX8907C_TOPOFF_20PERCENT,
	.restart_hysteresis	= MAX8907C_RESTART_100MV,
//*.fast_charging_current	= MAX8907C_FASTCHARGE_460MA,
	.fast_charging_current	= MAX8907C_FASTCHARGE_900MA,
	.fast_charger_time	= MAX8907C_FCHARGE_TM_OFF,
};

static struct platform_device n1_charger_device = {
	.name	= "max8907c-charger",
	.dev	= {
		.platform_data	= &n1_charger_pdata,
	},
};

static struct regulator_consumer_supply max8907c_SD1_supply[] = {
	/* REGULATOR_SUPPLY("VDDR2", NULL), */
};

static struct regulator_consumer_supply max8907c_SD2_supply[] = {
	REGULATOR_SUPPLY("vdd_core", NULL),
	REGULATOR_SUPPLY("vdd_aon", NULL),
};

static struct regulator_consumer_supply max8907c_SD3_supply[] = {
	/* REGULATOR_SUPPLY("VAP_IO", NULL), */
};

static struct regulator_consumer_supply max8907c_LDO1_supply[] = {
	REGULATOR_SUPPLY("VADC_3V3", NULL),
};

static struct regulator_consumer_supply max8907c_LDO2_supply[] = {
	REGULATOR_SUPPLY("VAP_PLL_1V1", NULL),
};

static struct regulator_consumer_supply max8907c_LDO3_supply[] = {
	REGULATOR_SUPPLY("VLCD_1V8", NULL),
};

static struct regulator_consumer_supply max8907c_LDO4_supply[] = {
	REGULATOR_SUPPLY("VAP_USB_3V3", NULL),
};

static struct regulator_consumer_supply max8907c_LDO5_supply[] = {
	REGULATOR_SUPPLY("VCC_3V3_MHL", NULL),
};

static struct regulator_consumer_supply max8907c_LDO6_supply[] = {
	REGULATOR_SUPPLY("AVDD_HDMI_PLL_1V8", NULL),
};

static struct regulator_consumer_supply max8907c_LDO7_supply[] = {
	REGULATOR_SUPPLY("VCC_1V8_MHL", NULL),
};

static struct regulator_consumer_supply max8907c_LDO8_supply[] = {
	REGULATOR_SUPPLY("LED_A_2V8", NULL),
};

static struct regulator_consumer_supply max8907c_LDO9_supply[] = {
	/* REGULATOR_SUPPLY("VFUSE_3V3", NULL), */
};

static struct regulator_consumer_supply max8907c_LDO10_supply[] = {
	REGULATOR_SUPPLY("VSENSOR_1V8", NULL),
};

static struct regulator_consumer_supply max8907c_LDO11_supply[] = {
	REGULATOR_SUPPLY("VCC_2V8_PDA", NULL),
};

static struct regulator_consumer_supply max8907c_LDO12_supply[] = {
	REGULATOR_SUPPLY("VLCD_3V0", NULL),
};

static struct regulator_consumer_supply max8907c_LDO13_supply[] = {
	REGULATOR_SUPPLY("TSP_AVDD_3V3", NULL),
};

static struct regulator_consumer_supply max8907c_LDO14_supply[] = {
	REGULATOR_SUPPLY("TSP_VDD_LVSIO", NULL),
};

static struct regulator_consumer_supply max8907c_LDO15_supply[] = {
	REGULATOR_SUPPLY("VCMC623_IO_1V8", NULL),
};

static struct regulator_consumer_supply max8907c_LDO16_supply[] = {
	REGULATOR_SUPPLY("VTF_3V3", NULL),
	REGULATOR_SUPPLY("vmmc", "sdhci-tegra.2"),
};

static struct regulator_consumer_supply max8907c_LDO17_supply[] = {
	REGULATOR_SUPPLY("VAP_MIPI_1V2", NULL),
};

static struct regulator_consumer_supply max8907c_LDO18_supply[] = {
	REGULATOR_SUPPLY("TSP_VDD_1V8", NULL),
};

static struct regulator_consumer_supply max8907c_LDO19_supply[] = {
	REGULATOR_SUPPLY("AVDD_HDMI_3V3", NULL),
};

static struct regulator_consumer_supply max8907c_LDO20_supply[] = {
	REGULATOR_SUPPLY("VCC_3V0_MOTOR", NULL),
};

static struct regulator_consumer_supply max8907c_OUT5V_supply[] = {
	/* REGULATOR_SUPPLY("VUSB", NULL), */
};

#define MAX8907C_REGULATOR_DEVICE(_id, _minmv, _maxmv, _sys_on,		\
	_init_on, _apply)	\
static struct regulator_init_data max8907c_##_id##_data = {		\
	.constraints = {						\
		.min_uV = (_minmv),					\
		.max_uV = (_maxmv),					\
		.valid_modes_mask = (REGULATOR_MODE_NORMAL |		\
				     REGULATOR_MODE_STANDBY),		\
		.valid_ops_mask = (REGULATOR_CHANGE_MODE |		\
				   REGULATOR_CHANGE_STATUS |		\
				   REGULATOR_CHANGE_VOLTAGE),		\
		.always_on = _sys_on,			\
		.boot_on = _init_on,				\
		.apply_uV = _apply,					\
	},								\
	.num_consumer_supplies = ARRAY_SIZE(max8907c_##_id##_supply),	\
	.consumer_supplies = max8907c_##_id##_supply,			\
};									\
static struct platform_device max8907c_##_id##_device = {		\
	.name	= "max8907c-regulator",					\
	.id	= MAX8907C_##_id,					\
	.dev	= {							\
		.platform_data = &max8907c_##_id##_data,		\
	},								\
}

#define ON		1
#define OFF		0


MAX8907C_REGULATOR_DEVICE(SD1, 637500, 1425000, ON, ON, ON);
MAX8907C_REGULATOR_DEVICE(SD2, 637500, 1425000, ON, ON, ON);
MAX8907C_REGULATOR_DEVICE(SD3, 750000, 3900000, ON, ON, ON);
MAX8907C_REGULATOR_DEVICE(LDO1, 3300000, 3300000, ON, ON, ON);
MAX8907C_REGULATOR_DEVICE(LDO2, 1100000, 1100000, ON, ON, ON);
MAX8907C_REGULATOR_DEVICE(LDO3, 1800000, 1800000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO4, 3300000, 3300000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO5, 3300000, 3300000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO6, 1800000, 1800000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO7, 1800000, 1800000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO8, 2800000, 2800000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO9, 3300000, 3300000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO10, 1800000, 1800000, ON, ON, ON);
MAX8907C_REGULATOR_DEVICE(LDO11, 2800000, 2800000, ON, ON, ON);
MAX8907C_REGULATOR_DEVICE(LDO12, 3000000, 3000000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO13, 3300000, 3300000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO14, 2800000, 2800000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO15, 1800000, 1800000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO16, 3300000, 3300000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO17, 1200000, 1200000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO18, 1800000, 1800000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO19, 3300000, 3300000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(LDO20, 3000000, 3000000, OFF, OFF, ON);
MAX8907C_REGULATOR_DEVICE(OUT5V, 5000000, 5000000, ON, ON, OFF);

static struct platform_device *n1_max8907c_power_devices[] = {
	&max8907c_SD1_device,
	&max8907c_SD2_device,
	&max8907c_SD3_device,
	&max8907c_LDO1_device,
	&max8907c_LDO2_device,
	&max8907c_LDO3_device,
	&max8907c_LDO4_device,
	&max8907c_LDO5_device,
	&max8907c_LDO6_device,
	&max8907c_LDO7_device,
	&max8907c_LDO8_device,
	&max8907c_LDO9_device,
	/* Switch 11&10 for Sensor power margin */
	&max8907c_LDO11_device,
	&max8907c_LDO10_device,
	&max8907c_LDO12_device,
	&max8907c_LDO13_device,
	&max8907c_LDO14_device,
	&max8907c_LDO15_device,
	&max8907c_LDO16_device,
	&max8907c_LDO17_device,
	&max8907c_LDO18_device,
	&max8907c_LDO19_device,
	&max8907c_LDO20_device,
	&max8907c_OUT5V_device,
	&n1_charger_device,
};

static struct max8907c_platform_data max8907c_pdata = {
	.num_subdevs = ARRAY_SIZE(n1_max8907c_power_devices),
	.subdevs = n1_max8907c_power_devices,
	.irq_base = TEGRA_NR_IRQS,
	.use_power_off = true,
};

static struct regulator_consumer_supply max8952_MODE1_supply[] = {
	REGULATOR_SUPPLY("vdd_cpu", NULL),
};

#define MAX8952_REGULATOR_INIT(_id, _minmv, _maxmv)			\
static struct regulator_init_data max8952_##_id##_data = {		\
	.supply_regulator = "SD3",					\
	.constraints = {						\
		.min_uV = (_minmv),					\
		.max_uV = (_maxmv),					\
		.valid_modes_mask = (REGULATOR_MODE_NORMAL |		\
				     REGULATOR_MODE_STANDBY),		\
		.valid_ops_mask = (REGULATOR_CHANGE_MODE |		\
				   REGULATOR_CHANGE_STATUS |		\
				   REGULATOR_CHANGE_VOLTAGE),		\
	},								\
	.num_consumer_supplies = ARRAY_SIZE(max8952_##_id##_supply),	\
	.consumer_supplies = max8952_##_id##_supply,			\
};									\
static struct platform_device max8952_##_id##_device = {		\
	.id	= MAX8952_##_id,					\
	.dev	= {							\
		.platform_data = &max8952_##_id##_data,			\
	},								\
}

MAX8952_REGULATOR_INIT(MODE1, 750000, 1100000);

static struct platform_device *n1_max8952_power_devices[] = {
	&max8952_MODE1_device,
};

static struct max8952_platform_data max8952_pdata = {
	.num_subdevs = ARRAY_SIZE(n1_max8952_power_devices),
	.subdevs = n1_max8952_power_devices,
};

static struct i2c_board_info __initdata n1_regulators[] = {
	{
		I2C_BOARD_INFO("max8907c", 0x3C),
		.irq = INT_EXTERNAL_PMU,
		.platform_data	= &max8907c_pdata,
	},
	{
		I2C_BOARD_INFO("max8952", 0x60),
		.platform_data = &max8952_pdata,
	},
};

static void n1_board_suspend(int lp_state, enum suspend_stage stg)
{
	if ((lp_state == TEGRA_SUSPEND_LP1) && (stg == TEGRA_SUSPEND_BEFORE_CPU))
		tegra_console_uart_suspend();
}

static void n1_board_resume(int lp_state, enum resume_stage stg)
{
	if ((lp_state == TEGRA_SUSPEND_LP1) && (stg == TEGRA_RESUME_AFTER_CPU))
		tegra_console_uart_resume();
}

static struct tegra_suspend_platform_data n1_suspend_data = {
	.cpu_timer	= 2000,
	.cpu_off_timer	= 0,
	.suspend_mode	= TEGRA_SUSPEND_LP0,
	.core_timer	= 0x7e7e,
	.core_off_timer = 0,
	.separate_req	= true,
	.corereq_high	= true,
	.sysclkreq_high	= true,
	.wake_enb	= TEGRA_WAKE_GPIO_PO5 \
					| TEGRA_WAKE_GPIO_PU5 \
					| TEGRA_WAKE_PWR_INT \
					| TEGRA_WAKE_GPIO_PY6,
	.wake_high	= TEGRA_WAKE_GPIO_PU5,
	.wake_low	= TEGRA_WAKE_GPIO_PO5 \
				| TEGRA_WAKE_PWR_INT \
				| TEGRA_WAKE_GPIO_PY6,
	.wake_any	= 0,
};

int __init n1_regulator_init(void)
{
	void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
	void __iomem *chip_id = IO_ADDRESS(TEGRA_APB_MISC_BASE) + 0x804;
	u32 pmc_ctrl;
	u32 minor;

	minor = (readl(chip_id) >> 16) & 0xf;
	/* A03 (but not A03p) chips do not support LP0 */
	if (minor == 3 && !(tegra_spare_fuse(18) || tegra_spare_fuse(19)))
		n1_suspend_data.suspend_mode = TEGRA_SUSPEND_LP1;

	/* configure the power management controller to trigger PMU
	 * interrupts when low */
	pmc_ctrl = readl(pmc + PMC_CTRL);
	writel(pmc_ctrl | PMC_CTRL_INTR_LOW, pmc + PMC_CTRL);

	i2c_register_board_info(4, n1_regulators, ARRAY_SIZE(n1_regulators));

	regulator_has_full_constraints();
	tegra_init_suspend(&n1_suspend_data);

	return 0;
}

