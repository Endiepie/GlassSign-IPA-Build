# GlassSign

GlassSign is a personal, on-device IPA signer and installer. It is based on [Feather](https://github.com/claration/feather), whose signing, certificate, and installation code is licensed under GPL-3.0. The upstream `LICENSE` and project attribution are retained.

## What is customized

- GlassSign name, `com.buse.glassign` bundle ID, URL scheme, and custom signature mark.
- A Liquid Glass first-run screen and the system Liquid Glass navigation on iOS 26 and later, with a material fallback on older iOS versions.
- A local-first layout with Apps, Certificates, and Settings as the main tabs. Repository browsing is not shown by default.
- A MobileHouseArrest safeguard: for `com.apple.mobile.MobileHouseArrest`, GlassSign preserves the original identifier, suppresses the random PPQ suffix, and locks the identifier field. This addresses the `.LDNCVG3TPZ`-style suffix shown in the reported 9400 error.
- Signing defaults to install the app after signing.

## Build and install GlassSign

A native iOS IPA must be built with Xcode on macOS. This workspace is Windows-only and has no `xcodebuild`, so it contains the customized source project rather than a compiled GlassSign IPA.

1. Open `Feather.xcworkspace` in Xcode 26 or later.
2. Select the `Feather` scheme and set your own Apple development team and a bundle ID available to that team. The current personal default is `com.buse.glassign`.
3. Build and install GlassSign to your iPhone using your own signing setup.
4. In GlassSign, import the `.p12` certificate and matching `.mobileprovision` profile, then import the IPA you want to sign.

GlassSign itself has to be installed once before it can sign other apps. It cannot bootstrap its own installation or create a signing certificate/profile.

## The 3105 / error 9400 case

GlassSign no longer appends a random suffix to 3105's identifier, so it avoids turning `com.apple.mobile.MobileHouseArrest` into an identifier such as `com.apple.mobile.MobileHouseArrest.LDNCVG3TPZ`. It keeps the identifier unchanged because 3105's [upstream installation notes](https://github.com/YangJiiii/3105#installation-notes) say the MobileHouseArrest workflow depends on that exact value and document enterprise-certificate signing.

This safeguard cannot make an unavailable App ID available to an Apple account. Signing still needs a certificate and profile authorized for the exact identifier. If the signing service rejects the base identifier with error 9400, GlassSign cannot override that decision; the correct certificate/profile and distribution route are still required.

## License

This is a personal modified build of Feather. The source remains under GPL-3.0; see `LICENSE` and the upstream project for notices and credits.
