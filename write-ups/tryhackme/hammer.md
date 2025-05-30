# Hammer

{% embed url="https://tryhackme.com/room/hammer" %}

## **Trying to access port 80**

* failed, port 80 not open

## **Using nmap to discover web application port**

```bash
$ nmap <target> -p- -v
...
port 1137
...
```

* found port 1337 (labelled as waste, but is actually running  a HTTP web server)



## Enumeration

### **Directory discovery**

```bash
$ gobuster dir -x php -u <target>:1337/ -w /user/share/wordlists/SecLists/Discovery/Web-Content/common.txt
```

<figure><img src="../../.gitbook/assets/image (13).png" alt=""><figcaption></figcaption></figure>

**/config.php** -> empty page with no interesting source code content

**/javascript** and **/vendor**-> FORBIDDEN

**/phpmyadmin** -> php admin login page



## Exploring the /phpmyadmin page

* upon visiting this page, I was presented with a login page
* trying out common username:password combinations yield no results

#### **Combinations**

1. root: (empty password) -> returned an error
2. root:root
3. root:toor
4. admin:admin
5. mysql:mysql

The other combinations aside from the 1st returned:

`mysqli_real_connect(): (HY000/1045): Access denied for user 'root'@'localhost' (using password: YES)`

_**Interesting information from a script tag within the response from this page**_

```html
<script data-cfasync="false" type="text/javascript">
// <![CDATA[
PMA_commonParams.setAll({common_query:"",opendb_url:"db_structure.php",lang:"en",server:"1",table:"",db:"",token:"7935597b257d3e495236647a2d434037",text_dir:"ltr",show_databases_navigation_as_tree:true,pma_text_default_tab:"Browse",pma_text_left_default_tab:"Structure",pma_text_left_default_tab2:false,LimitChars:"50",pftext:"",confirm:true,LoginCookieValidity:"1440",session_gc_maxlifetime:"1440",logged_in:false,is_https:false,rootPath:"/phpmyadmin/",arg_separator:"&",PMA_VERSION:"4.9.5deb2",auth_type:"cookie",user:"root"});
ConsoleEnterExecutes=false
AJAX.scriptHandler.add("vendor/jquery/jquery.min.js",0).add("vendor/jquery/jquery-migrate.js",0).add("whitelist.php",1).add("vendor/sprintf.js",1).add("ajax.js",0).add("keyhandler.js",1).add("vendor/jquery/jquery-ui.min.js",0).add("vendor/js.cookie.js",1).add("vendor/jquery/jquery.mousewheel.js",0).add("vendor/jquery/jquery.event.drag-2.2.js",0).add("vendor/jquery/jquery.validate.js",0).add("vendor/jquery/jquery-ui-timepicker-addon.js",0).add("vendor/jquery/jquery.ba-hashchange-1.3.js",0).add("vendor/jquery/jquery.debounce-1.0.5.js",0).add("menu-resizer.js",1).add("cross_framing_protection.js",0).add("rte.js",1).add("vendor/tracekit.js",1).add("error_report.js",1).add("messages.php",0).add("config.js",1).add("doclinks.js",1).add("functions.js",1).add("navigation.js",1).add("indexes.js",1).add("common.js",1).add("page_settings.js",1).add("shortcuts_handler.js",1).add("vendor/codemirror/lib/codemirror.js",0).add("vendor/codemirror/mode/sql/sql.js",0).add("vendor/codemirror/addon/runmode/runmode.js",0).add("vendor/codemirror/addon/hint/show-hint.js",0).add("vendor/codemirror/addon/hint/sql-hint.js",0).add("vendor/codemirror/addon/lint/lint.js",0).add("codemirror/addon/lint/sql-lint.js",0).add("console.js",1);
$(function() {AJAX.fireOnload("whitelist.php");AJAX.fireOnload("vendor/sprintf.js");AJAX.fireOnload("keyhandler.js");AJAX.fireOnload("vendor/js.cookie.js");AJAX.fireOnload("menu-resizer.js");AJAX.fireOnload("rte.js");AJAX.fireOnload("vendor/tracekit.js");AJAX.fireOnload("error_report.js");AJAX.fireOnload("config.js");AJAX.fireOnload("doclinks.js");AJAX.fireOnload("functions.js");AJAX.fireOnload("navigation.js");AJAX.fireOnload("indexes.js");AJAX.fireOnload("common.js");AJAX.fireOnload("page_settings.js");AJAX.fireOnload("shortcuts_handler.js");AJAX.fireOnload("console.js");});
// ]]>
</script>

```

**What can we gather from this script?**

1. `token:"7935597b257d3e495236647a2d434037"`&#x20;
2. `PMA_VERSION:"4.9.5deb2"`
3. `auth_type:"cookie"`
4. `user:"root"`
5. `AJAX.fireOnload("whitelist.php");`



