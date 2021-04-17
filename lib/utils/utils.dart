void runCatching(Function action, {Function? onError}) {
  try {
    action();
  } catch (E) {
    onError?.call(E);
  }
}
