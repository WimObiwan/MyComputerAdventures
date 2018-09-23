---
title: "RDP credential caching"
tags: [windows, mstsc, rdp]
image: rdp-client-credential-caching.jpeg
---

In Microsoft's RDP client, you can enable a checkbox to save your password.  Usually, this doesn't work, because by default delegating the credentials isn't allowed by the Group Policy.  This post explains how to enable this.

<!--more-->

When you connect to a *Terminal Server*, you can get this error message when using saved credentials: **Your credentials didn't work.  The credentials that were used to connect to *\[some server\]* did not work.  Please enter new credentials.**
![Enable](rdp-client-credential-caching-0.png) 


Follow these steps to enable delegating credentials:

1. Open the *Group Policy Editor* as *administrator*:  
   One way to do this is:

   * Press the *Windows-key*, and type `Powershell`.  
   * Powershell will be found: right click on the result, and select *Run as administrator*.
   * In the *Powershell prompt*, type `gpedit.msc`,and press Enter. 

2. Update the settings in the *Group Policy Editor*:

   * In the left-side tree pane, navigate to:

      * Local Computer Policy
      * Computer Configuration
      * Administrative Templates
      * System
      * Credentials Delegation

   * In the right pane, double click on:

      * Allow delegating saved credentials with NTLM-only server authentication  
        ![Allow delegating saved credentials with NTLM-only server authentication](rdp-client-credential-caching-1.png)

   * Select the radio button *Enabled*:  
     ![Enable](rdp-client-credential-caching-2.png) 

   * Click on *Show...* beside *Add servers to the list*.

   * Add a new entry `TERMSRV/*`to enable delegation for all servers:  
     ![Enable](rdp-client-credential-caching-3.png) 

   * Repeat the same for *Allow delegating saved credentials*.

3. Apply the *Group Policy* with the new changes:

   * In the *Powershell prompt*, run the command `gpupdate`.
