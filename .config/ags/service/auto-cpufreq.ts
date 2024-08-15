import { sh } from "lib/utils";

type Profile = "Powersave" | "Performance" | "Default";
class AutoCPUFreq extends Service {
  static {
    Service.register(
      this,
      {},
      {
        profile: ["string", "r"],
      },
    );
  }

  get available() {
    return Utils.exec(
      "which auto-cpufreq",
      () => true,
      () => false,
    );
  }

  #profile: Profile = "Default";

  constructor() {
    super();

    if (this.available) {
      sh("auto-cpufreq --get-state").then((p) => (this.#profile = p.title()));
    }
  }

  get profiles(): Profile[] {
    return ["Powersave", "Performance"];
  }
  get profile() {
    return this.#profile;
  }
}

export default new AutoCPUFreq();
