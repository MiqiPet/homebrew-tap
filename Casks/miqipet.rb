cask "miqipet" do
  version "0.1.18"
  sha256 "00703e81d5a84c19f876f9a7db633592e82c29986890fd2c849899d24a11ce64"

  url "https://dl.miqi.dev/releases/#{version}/MiqiPet-#{version}-mac-arm64.dmg"
  name "MiqiPet"
  desc "Desktop pet that shows what your coding agents are doing"
  homepage "https://miqi.dev/"

  livecheck do
    url "https://api.miqi.dev/api/v1/app/latest?os=mac&arch=arm64"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on :macos

  app "MiqiPet.app"

  uninstall launchctl: "dev.miqi.pet",
            quit:      "dev.miqi.pet",
            script:    {
              executable:   "/usr/bin/pkill",
              args:         ["-f", "^#{appdir}/MiqiPet.app/Contents/MacOS/MiqiPet --daemon"],
              must_succeed: false,
            }

  zap trash: [
    "~/.miqipet",
    "~/Library/Caches/dev.miqi.MiqiPet",
    "~/Library/Caches/dev.miqi.pet",
    "~/Library/LaunchAgents/dev.miqi.pet.plist",
    "~/Library/Preferences/dev.miqi.pet.plist",
    "~/Library/WebKit/dev.miqi.MiqiPet",
    "~/Library/WebKit/dev.miqi.pet",
  ]
end
