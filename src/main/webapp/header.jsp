<%--
  Created by IntelliJ IDEA.
  User: colour93
  Date: 2023/6/15
  Time: 23:57
  To change this template use File | Settings | File Templates.
--%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="//fur233.oss-cn-hangzhou.aliyuncs.com/common/css/mdui.min.css">
    <title>Shopping</title>
    <style>

        .products-item {
            margin-top: 10px;
        }

        .login-box {
            width: 400px;
            padding: 30px;
        }

        .login-content {
            height: 100vh;
            width: 100vw;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .comment-product {
            margin-top: 20px;
            display: flex;
        }

        .comment-product-image {
            height: 200px;
        }

        .comment-product-info {
            padding: 20px;
        }

        .comment-product-info > * {
            margin: 10px;
        }

        .comment-product-info-title {
            font-size: 32px;
        }

        .comment-product-info-subtitle {
            font-size: 20px;
        }

        .comment-sender-bottom {
            display: flex;
            justify-content: end;
            align-items: center;
        }

        .comment-sender-bottom > * {
            margin: 10px;
        }

        .comment-item {
            margin: 40px 0;
        }

        .comment-item-sender {
            display: flex;
            align-items: center;
            margin: 10px 0;
        }

        .comment-item-sender > * {
            margin-right: 5px;
        }

        #sidebar {
            position: fixed;
            top: 0;
            right: -300px;
            width: 300px;
            height: 100vh;
            margin: 0;
            padding: 0;
            transition: right .3s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: auto;
        }

        .cart-item {
            display: flex;
            align-items: center;
            margin: 15px;
            padding: 5px;
        }

        .cart-item>* {
            margin: 5px;
        }

        .cart-item-cover {
            height: 64px;
            width: 64px;
            object-fit: contain;
        }

        .cart-item-title {
            font-weight: 900;
        }

        .cart-item-content {
            flex-grow: 1;
        }

    </style>
</head>
<body class="mdui-theme-primary-indigo mdui-theme-accent-pink">