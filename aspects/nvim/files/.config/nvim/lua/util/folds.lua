function M.fold_info(winid, lnum)
  local win_T_ptr = ffi.C.find_window_by_handle(winid, error)
  if win_T_ptr == nil then
    return
  end
  return ffi.C.fold_info(win_T_ptr, lnum)
end
