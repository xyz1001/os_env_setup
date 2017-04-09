# StarUML

## 破解

1. 查找`LicenseManagerDomain.js`文件

默认位于`/opt/staruml/www/license/node/LicenseManagerDomain.js`

2. 找到`function validate(PK, name, product, licenseKey)`，在`var pk, decrypted;`后添加以下代码

```
return {
    name: "0xcb",
    product: "StarUML",
    licenseType: "vip",
    quantity: "bbs.chinapyg.com"
    licenseKey: "later equals never!"
};
```

3. 运行软件，帮助-输入注册码-确定（存在未知原因会失败）
