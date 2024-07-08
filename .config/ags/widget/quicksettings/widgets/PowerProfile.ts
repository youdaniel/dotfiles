import { SimpleToggleButton } from "../ToggleButton";
import icons from "lib/icons";

import autoCpuFreq from "service/auto-cpufreq";
const autoCPUFreqProf = autoCpuFreq.bind("profile");

const AutoCPUFreqToggle = () =>
  SimpleToggleButton({
    icon: autoCPUFreqProf.as((p) => icons.autoCPUFreq.profile[p]),
    label: autoCPUFreqProf,
    connection: [autoCpuFreq, () => autoCpuFreq.profile !== "Default"],
    toggle: () => Utils.execAsync("auto-cpufreq-gtk"),
  });

export const ProfileToggle = AutoCPUFreqToggle;
