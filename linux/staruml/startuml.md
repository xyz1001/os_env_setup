# StarUML

## 破解

1. 查找`LicenseManagerDomain.js`文件

默认位于`/opt/staruml/www/license/node/LicenseManagerDomain.js`

2. 找到`function validate(PK, name, product, licenseKey)`，在`var pk, decrypted;`后添加以下代码

```
return {
    name: "0xcb",   //随意，稍后需要填写的用户名
    product: "StarUML",
    licenseType: "vip",
    quantity: "www.qq.com"  //随意
    licenseKey: "later equals never!"   //注册码
};
```
命令为：
```
sudo sed -i "/var pk, decrypted/a\        return \{\n            name: \"0xcb\",\n            product: \"StarUML\",\n            licenseType: \"vip\",\n            quantity: \"www.qq.com\",\n            licenseKey: \"later equals never\!\"\n        \};" /opt/staruml/www/license/node/LicenseManagerDomain.js
```

3. 运行软件，帮助-输入注册码-确定
用户名为0xcb，注册码为later equals never!


