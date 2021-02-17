function avatarSizeCheck() {
  const user_avatar = document.getElementById("user_avatar")
  const avatar_form = document.getElementById("avatar_form")
  user_avatar.addEventListener("change", () => {
    const size_in_megabytes = user_avatar.files[0].size/1024/1024;
    if (size_in_megabytes > 2) {
      alert("2MB以下のファイルを選択してください。");
      user_avatar.value = "";
    } else {
      avatar_form.submit();
    }
  });
}
avatarSizeCheck();