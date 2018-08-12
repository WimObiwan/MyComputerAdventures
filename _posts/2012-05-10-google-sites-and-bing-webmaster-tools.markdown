---
title: "Google Sites and Bing Webmaster Tools ownership verification"
tags: [sites]
image: /assets/2012-05-10-google-sites-and-bing-webmaster-tools-0.png
---

Google sites removes the *dot* in the verification `meta`-tag of the Bing Webmaster Tools.  Luckily, there is a workaround.

<!--more-->  

When registering your Google Sites site in Microsoft Bing Webmaster Tools, you get 3 options to proof your ownership of the site. 
The easiest way is to choose for option 2 with the `<meta>`-tag.  

The meta tag is similar to this:

```html
<meta name="msvalidate.01" content="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" />
```

Bing asks you to add the `<meta>`-tag to the `<head>` section of your website.

In your *Google Sites* site, go to the site settings (`Manage Site`) and click `General` on the left column.  One of the settings is `Google Webmaster Tools`.
Copy paste the `<meta>`-tag above to the `Google Webmaster Tools` setting.
When you click `Save`, and inspect the source of your Google Sites site, you will find the `<meta>`-tag, but for some reason, the name is changed from
`msvalidate.01` to `msvalidate01` (**without the dot**). Consequently, Bing Webmaster Tools tells that the `meta`-tag is missing, and they could net verify your ownership of the site.

![Screenshot](/assets/2012-05-10-google-sites-and-bing-webmaster-tools-1.png)

A workaround for this problem is to use `msvalidate-01` (**with a hyphen**) instead of `msvalidate.01`. 
The hyphen is correctly displayed in the source of the website, and Bing Webmaster Tools succesfully validates your ownership of the site.
