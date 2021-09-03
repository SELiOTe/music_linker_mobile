/// 常量工具
/// 
/// @author seliote
/// @version 2021-09-03

// 图形验证码正则
const CAPTCHA_REGEX = r'^[a-zA-Z\d]{4}$';
// 短信验证码正则
const VERIFY_CODE_REGEX = r'^\d{6}$';
// 密码校验正则，8 位以上非空字符且同时包含字母数字
const PASSWORD_REGEX = r'^(?=\S*[a-zA-Z])(?=\S*\d)\S{8,}$';