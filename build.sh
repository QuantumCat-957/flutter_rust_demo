cargo install flutter_rust_bridge_codegen
cargo install cargo-expand

flutter_rust_bridge_codegen -r hello_world/src/api.rs \
-d ./plugin_demo/lib/bridge_generated.dart \
--dart-decl-output ./plugin_demo/lib/bridge_definitions.dart \
-c ./libs/ios/hello_world.h

rustup target add armv7-linux-androideabi
rustup target add aarch64-linux-android
rustup target add x86_64-linux-android
rustup target add i686-linux-android
rustup target add aarch64-apple-ios
rustup target add x86_64-apple-ios

cd hello_world
cargo clean
cargo xcode
cargo update

cargo ndk -t armeabi-v7a -t arm64-v8a -t x86_64 -t x86 -o ../libs/android/jniLibs build --release

cargo install cargo-lipo
cargo lipo --release 

cd ..

cp -R libs/android/jniLibs plugin_demo/example/android/app/src/main/
cp -r libs/ios/hello_world.h  plugin_demo/example/ios/Runner/hello_world.h
cp -r ./hello_world/target/universal/release/libhello_world.a  libs/ios/libhello_world.a
