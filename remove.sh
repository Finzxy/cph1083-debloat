#!/bin/bash
# CPH1803 Safe Debloat — ~80 packages, no important features removed
# Run: bash cph1803_safe_debloat.sh

PKG=(
  # NearMe suite (all safe)
  com.nearme.themespace
  com.nearme.gamecenter
  com.nearme.statistics.rom
  com.nearme.atlas
  com.nearme.deamon
  com.nearme.romupdate

  # Diagnostic / test tools (factory test tools, not used by normal users)
  com.oppo.logkit
  com.oppo.logkitsdservice
  com.oppo.criticallog
  com.oppo.rftoolkit
  com.oppo.wifirf
  com.oppo.engineermode
  com.oppo.bttestmode
  com.oppo.fingerprints.fingerprintsensortest
  com.oppo.freefallingmonitor
  com.oppo.oppopowermonitor
  com.qualcomm.qti.qmmi
  com.qualcomm.qti.modemtestmode
  com.wifi.rxsenstest

  # Qualcomm sample auth (testing stub, not production auth)
  com.qualcomm.qti.auth.sampleextauthservice
  com.qualcomm.qti.auth.sampleauthenticatorservice
  com.qualcomm.qti.auth.securesampleauthservice
  com.qualcomm.qti.auth.secureextauthservice

  # Unused Qualcomm services
  com.qualcomm.embms               # LTE broadcast — not deployed in Indonesia
  com.qualcomm.cabl                # Minor backlight algorithm
  com.qualcomm.svi
  com.qualcomm.qti.accesscache
  com.qti.qualcomm.deviceinfo
  com.qti.qualcomm.datastatusnotification
  com.qti.confuridialer            # Conference URI dialer — rare feature
  com.qti.service.colorservice

  # Google bloat (not core GMS — safe to remove)
  com.google.android.googlequicksearchbox
  com.google.android.onetimeinitializer
  com.google.android.marvin.talkback
  com.google.android.tts
  com.google.android.tag
  com.google.android.partnersetup
  com.google.android.printservice.recommendation
  com.google.android.feedback
  com.google.android.backuptransport
  com.google.android.configupdater
  com.google.android.setupwizard   # Safe after setup completes

  # OPPO bloat apps
  com.oppo.market                  # Replaced by Play Store
  com.oppo.music                   # Already have Metrolist
  com.oppo.operationManual
  com.oppo.quicksearchbox
  com.oppoex.afterservice
  com.oppo.usercenter              # OPPO account
  com.oppo.tzupdate
  com.oppo.nw
  com.oppo.resmonitor
  com.oppo.localservice
  com.oppo.lfeh

  # ColorOS bloat
  com.coloros.childrenspace
  com.coloros.avastofferwall       # Avast ads
  com.coloros.gamespace
  com.coloros.cloud
  com.coloros.prome.smsservice     # Promo SMS
  com.coloros.operationtips
  com.coloros.pictorial
  com.coloros.colorfilestand
  com.coloros.athena               # Breeno AI assistant
  com.coloros.wifibackuprestore
  com.coloros.phonenoareainquire
  com.coloros.wallpapers
  com.coloros.translate.engine
  com.coloros.providers.fileinfo
  com.coloros.healthcheck
  com.coloros.lockassistant
  com.coloros.smartdrive           # Driving mode
  com.coloros.compass
  com.coloros.providers.downloads.ui
  com.coloros.video                # Use VLC/MPV
  com.coloros.soundrecorder

  # Android misc bloat
  com.android.cts.priv.ctsshim
  com.android.cts.ctsshim
  com.dropboxchmod
  com.android.dlna.service
  com.android.email.partnerprovider
  com.android.providers.partnerbookmarks
  com.android.wallpaper.livepicker
  com.android.wallpaperbackup
  com.android.printspooler
  com.android.htmlviewer
  com.android.bips                 # Bluetooth print
  com.wapi.wapicertmanage          # WAPI (China WiFi standard)
  com.dsi.ant.server               # ANT+ fitness protocol
  android.autoinstalls.config.oppo
  com.android.providers.applications
  com.daemon.shelper
  com.android.smspush              # WAP push config
  com.mediatek.omacp               # OMA provisioning
  com.ted.number
  com.wo.voice2
  com.caf.fmradio
)

for pkg in "${PKG[@]}"; do
  echo -n "[$pkg] "
  adb shell pm uninstall -k --user 0 "$pkg" 2>&1 | grep -oE "Success|Failure|Exception"
done

echo -e "\nDone. ~${#PKG[@]} packages processed."

# ============================================================
# DO NOT REMOVE — important features / tradeoffs:
# ============================================================
# com.coloros.weather + weather.service + widget.smallweather → weather widget
# com.coloros.blacklistapp + blacklist                        → call/SMS blocking
# com.coloros.wirelesssettings                               → WiFi calling settings
# com.color.eyeprotect                                       → night mode / reading mode
# com.oppo.aod                                               → Always On Display
# com.oppo.sos                                               → emergency SOS
# com.oppo.smartvolume                                       → smart volume
# com.qualcomm.wfd.service                                   → Miracast / screen mirror
# com.qualcomm.qti.uceShimService                           → VoLTE capability exchange
# com.qualcomm.qti.poweroffalarm                            → alarm when phone is off
# com.qualcomm.qti.loadcarrier                              → APN / carrier config
# com.qualcomm.qti.auth.fidocryptoservice                   → FIDO fingerprint (web/banking)
# com.qualcomm.qti.callfeaturessetting                      → call settings
# com.qualcomm.qti.autoregistration                         → SIM registration to carrier
# com.qti.xdivert                                           → call forward UI
# com.qti.dpmserviceapp                                     → data policy manager
# com.android.stk                                           → SIM Toolkit (Telkomsel menu, etc.)
# org.simalliance.openmobileapi.service                     → NFC / SIM payment
# com.axis.net                                              → keep if using Axis SIM card
# oppo                                                      → base package, skip