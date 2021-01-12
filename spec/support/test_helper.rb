def log_in_as(user)
  visit login_path
  fill_in 'メールアドレス', with: user.email
  fill_in 'パスワード', with: user.password
  find("#login_btn").click
end
# expect(page).to have_selector 'h1.information', text: '大事なお知らせ'