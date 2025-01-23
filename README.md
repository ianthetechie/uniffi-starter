# UniFFI Starter

This is a simple, mostly minimal, but more-complex-than-just-addition
demonstration of how to use [UniFFI](https://github.com/mozilla/uniffi-rs)
in a structure that works for MOST use cases.

The project has a Rust core, a Swift Package, and a Gradle project
in a structure that I've found to be fairly general.
The goal is for you to fork this as as starter to get past the boilerplate
and get started writing your cross-platform library.

## Motivating use case

As promised, it's more complex than addition, but it's intentionally
a bit ridiculous to keep things fun and demonstrate a wide range of uses
in a small project.
I say small, but note that the vast majority is boilerplate
Read on for a guide to the "good parts".

We're building a "safe" calculator that can do integer arithmetic.
(The usual demostrations of just addition are not complex enough to be very useful.)
The Rust core will provide addition and division operators.
The native code will show you how to supply your OWN operators written in Swift and Kotlin.
Because nobody knows where math is going next,
this OBVIOUSLY needs to be completely extensible with new operators ;)

By "safe" of course I mean that on the Rust side, everything returns a result,
which is translated into exceptions for iOS and Android.
At least you'll get a clean exception from Rust to let you know
about your integer overflows and division by zero!

Now if this is all starting to sound like every other over-engineered (read: ruined) 
Java project, it definitely is, but I hope it's useful
in showing a wide range of examples in an easy-to-understand project.

This demonstration library also embraces the
functional core/imperative shell architecture.
Jokes about over-engineering aside,
while this is total overkill for a calculator app,
you really SHOULD strongly consider using this pattern
for any non-trivial real-world library.

Hope this helps!

## Quick start

### Rust

Open up the project in your favorite editor and poke around the Cargo workspace
under `rust/`!

#### Stuff to look at 

* All of the code is in `foobar/src/lib.rs`, including several unit tests
to demonstrate the Rust API.
* Also check `Cargo.toml` and the overall workspace structure to see how a UniFFI project needs to be structured on the Rust side.
* Check out `rust-toolchain.toml`; **if you aren't using `rustup`, this is your checklist of toolchains to install!**

### iOS

Before opening up the Swift package in Xcode, you need to build the Rust core.

```shell
cd rust/
./build-ios.sh
```

This generates an XCFramework and generates Swift bindings to the Rust core.
Check the script if you're interested in the gritty details.

**You need to do this every time you make Rust changes that you want reflected in the Swift Package!**

#### Stuff to look at

* `Package.swift` documents the UniFFI setup (which is... special thanks to SPM quirks).
* `SafeCalculator` and `SafeMultiply` in `Sources/Foobar` contain the Swift-y calculator wrapper class and multiplication operator.
* The unit tests in `Tests/FoobarTests/SafeCalculatorTests.swift` demonstrate usage.

### Android

Android is pretty easy to get rolling, and Gradle will build everything for you
after you get a few things set up.
Most importantly, you need to install [`cargo-ndk`](https://github.com/bbqsrc/cargo-ndk).

```shell
cargo install cargo-ndk
```

If you've tried building the Rust library already and you have rustup,
the requisite targets will probably be installed automatically.
If not, follow the steps in the [`cargo-ndk` README](https://github.com/bbqsrc/cargo-ndk)
to install the required Android targets.

Just open up the `android` project in Android Studio and you're good to go.
It took forever to get the tooling right, but now that it's there, it just works.
Note that the app target is intentionally super barebones;
it's only there to illustrate how Gradle project dependencies work within a single workspace.

#### Stuff to look at

* The interesting stuff lives under the `SafeCalculator` and `SafeMultiply` classes.
* Also check out the tests for an example of usage.
* You can also check out the Android tests.
* The gradle files are mostly boilerplate, but there are a few things in there needed for building the Rust library. That took a while to figure out, and I currently believe this is the easiest approach.

## Learning more

Obviously, UniFFI's GitHub is probably the best place to learn more and ask questions.
If you're interested in following a slightly more serious dev log about using UniFFI
in a real library, check out the following:

* [Ferrostar on GitHub](https://github.com/stadiamaps/ferrostar) - a next gen navigation SDK I'm developing along with @Archdoog.
* Follow [Stadia Maps](https://stadiamaps.com/) on your favorite channel (scroll down to the bottom for social links and a newsletter). We occasionally post tech blogs like [this one](https://stadiamaps.com/news/ferrostar-building-a-cross-platform-navigation-sdk-in-rust-part-1/). Or [this one](https://stadiamaps.com/news/ferrostar-building-a-cross-platform-navigation-sdk-in-rust-part-2/)!
