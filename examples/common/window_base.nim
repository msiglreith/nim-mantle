
import windows

let className = "MantleWindowClass"

proc windowProc(window: HWND; msg: WINUINT; wparam: WPARAM; lparam: LPARAM): LRESULT {.stdcall, procvar.} =
  return DefWindowProc(window, msg, wparam, lparam)

proc registerWindowClass*() =
  var class = WNDCLASS(
                style: CS_HREDRAW or CS_VREDRAW,
                lpfnWndProc: windowProc,
                cbClsExtra: 0,
                cbWndExtra: 0,
                hInstance: GetModuleHandle(nil),
                hIcon: 0,
                hCursor: LoadCursor(0, IDC_ARROW),
                hbrBackground: 0,
                lpszMenuName: nil,
                lpszClassName: className
              )

  discard windows.RegisterClassA(addr class)

proc buildWindow*(width: int32, height: int32) =
  var hWindow = CreateWindowEx(
                dwExStyle = 0,
                lpClassName = className,
                lpWindowName = "nim-mantle",
                dwStyle = WS_THICKFRAME or WS_SYSMENU,
                X = 0,
                Y = 0,
                nWidth = width,
                nHeight = height,
                hWndParent = 0,
                menu = 0,
                hInstance = GetModuleHandle(nil),
                lpParam = nil
              )

  if hWindow == 0:
    quit()

  discard ShowWindow(hWindow, SW_SHOWDEFAULT)
  discard UpdateWindow(hWindow)

proc pollWindow*() =
  var msg: MSG
  while PeekMessage(addr msg, 0, 0, 0, PM_REMOVE) != 0:
    # echo "msg: ", msg
    discard TranslateMessage(addr msg)
    discard DispatchMessage(addr msg)
