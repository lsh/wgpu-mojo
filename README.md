**NOTE: THIS IS NOT A MODULAR PROJECT!!!**

# WGPU Mojo

This repo shows proof of concept bindings to [wgpu-native](https://github.com/gfx-rs/wgpu-native/).
These bindings are not in a state such that they can be used for anything production ready,
but one can at least reach a hello-triangle stage.

There is an example that can be run with:
```sh
magic run exec
```
respctively.

_Note: the C binding generator in `gen_c.py` is currently stale, so running it will break things._

## Limitations

* I've only written code to get the surface for MacOS.
* There are several structs like `WGPURequestAdapterOptions` that don't seem to work when used in an FFI call.
* In an FFI-callback, accessing the status struct seems to cause issues for some reason (but works if replaced with an UInt32).
* Due to the awkward stage the Mojo standard library is currently in with respect to collections (and the `CollectionElement` trait), some types need to be wrapped in `Arc` so they can be used in collections.
* Lifetime inference doesn't seem to be working well for structs like `RequestPipelineDescriptor`.

## References

* [Learn WebGPU](https://eliemichel.github.io/LearnWebGPU/) by Élie Michel and contributors.
* [wgpu-native](https://github.com/gfx-rs/wgpu-native/) (especially the triangle example).
* [webgpu-headers](https://github.com/webgpu-native/webgpu-headers/) the `webgpu.json` file is the `webgpu.yml` file from here (at the relevant commit for the `wgpu` version), converted to JSON.
* [zig-objc](https://github.com/mitchellh/zig-objc) by Mitchell Hashimoto for Objective-C bindings.
