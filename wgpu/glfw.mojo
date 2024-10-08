from sys import ffi
from utils import Span, StringSlice

var _glfw = ffi.DLHandle("libglfw.dylib", ffi.RTLD.LAZY)

var _window_should_close = _glfw.get_function[
    fn (UnsafePointer[_GLFWwindow]) -> Bool
]("glfwWindowShouldClose")

var _poll_events = _glfw.get_function[fn () -> None]("glfwPollEvents")


fn get_platform() -> Platform:
    """Returns the currently selected platform."""
    return _glfw.get_function[fn () -> Int32]("glfwGetPlatform")()


@value
struct Platform:
    var value: Int32

    alias win32 = Self(0x00060001)
    alias cocoa = Self(0x00060002)
    alias wayland = Self(0x00060003)
    alias x11 = Self(0x00060004)
    alias null = Self(0x00060005)

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __ne__(self, rhs: Self) -> Bool:
        return self.value != rhs.value


fn init():
    _glfw.get_function[fn () -> None]("glfwInit")()


fn terminate():
    _glfw.get_function[fn () -> None]("glfwTerminate")()


fn poll_events():
    _poll_events()


struct _GLFWwindow:
    pass


struct _GLFWmonitor:
    pass


struct _NSWindow:
    pass


struct Window:
    var _handle: UnsafePointer[_GLFWwindow]
    var title: String

    fn __init__(inout self, width: Int32, height: Int32, owned title: String):
        self.title = title
        self._handle = _glfw.get_function[
            fn (
                Int32,
                Int32,
                UnsafePointer[Int8],
                UnsafePointer[_GLFWmonitor],
                UnsafePointer[_GLFWwindow],
            ) -> UnsafePointer[_GLFWwindow]
        ]("glfwCreateWindow")(
            width,
            height,
            self.title.unsafe_cstr_ptr(),
            UnsafePointer[_GLFWmonitor](),
            UnsafePointer[_GLFWwindow](),
        )

    fn should_close(self) -> Bool:
        return _window_should_close(self._handle)

    fn get_cocoa_window(self) -> UnsafePointer[_NSWindow]:
        return _glfw.get_function[
            fn (UnsafePointer[_GLFWwindow]) -> UnsafePointer[_NSWindow]
        ]("glfwGetCocoaWindow")(self._handle)

    fn __del__(owned self):
        _glfw.get_function[fn (UnsafePointer[_GLFWwindow]) -> None](
            "glfwDestroyWindow"
        )(self._handle)
