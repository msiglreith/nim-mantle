
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

proc buildWindow*(width: int32, height: int32): HWND =
  var rect = RECT(TopLeft: TPoint(x: 0, y: 0), BottomRight: TPoint(x: width, y: height))
  discard AdjustWindowRectEx(addr rect, 0, cast[WINBOOL](false), 0)
  var hWindow = CreateWindowEx(
                dwExStyle = 0,
                lpClassName = className,
                lpWindowName = "nim-mantle",
                dwStyle = WS_THICKFRAME or WS_SYSMENU,
                X = rect.TopLeft.x,
                Y = rect.TopLeft.y,
                nWidth = rect.BottomRight.x - rect.TopLeft.x,
                nHeight = rect.BottomRight.y - rect.TopLeft.y,
                hWndParent = 0,
                menu = 0,
                hInstance = GetModuleHandle(nil),
                lpParam = nil
              )

  if hWindow == 0:
    quit()

  discard ShowWindow(hWindow, SW_SHOWDEFAULT)
  discard UpdateWindow(hWindow)
  
  return hWindow

proc pollWindow*() =
  var msg: MSG
  while PeekMessage(addr msg, 0, 0, 0, PM_REMOVE) != 0:
    # echo "msg: ", msg
    discard TranslateMessage(addr msg)
    discard DispatchMessage(addr msg)
