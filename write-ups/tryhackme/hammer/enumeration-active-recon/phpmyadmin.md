# /phpmyadmin

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

`mysqli_real_connect(): (HY000/1045): Access denied for user '<replace with username>'@'localhost' (using password: YES)`

**Interesting information from a script tag in this page**

```html
<script data-cfasync="false" type="text/javascript">
// <![CDATA[
PMA_commonParams.setAll({common_query:"",opendb_url:"db_structure.php",lang:"en",server:"1",table:"",db:"",token:"xxxx",text_dir:"ltr",show_databases_navigation_as_tree:true,pma_text_default_tab:"Browse",pma_text_left_default_tab:"Structure",pma_text_left_default_tab2:false,LimitChars:"50",pftext:"",confirm:true,LoginCookieValidity:"1440",session_gc_maxlifetime:"1440",logged_in:false,is_https:false,rootPath:"/phpmyadmin/",arg_separator:"&",PMA_VERSION:"4.9.5deb2",auth_type:"cookie",user:","<username>"});
ConsoleEnterExecutes=false
AJAX.scriptHandler.add("vendor/jquery/jquery.min.js",0).add("vendor/jquery/jquery-migrate.js",0).add("whitelist.php",1).add("vendor/sprintf.js",1).add("ajax.js",0).add("keyhandler.js",1).add("vendor/jquery/jquery-ui.min.js",0).add("vendor/js.cookie.js",1).add("vendor/jquery/jquery.mousewheel.js",0).add("vendor/jquery/jquery.event.drag-2.2.js",0).add("vendor/jquery/jquery.validate.js",0).add("vendor/jquery/jquery-ui-timepicker-addon.js",0).add("vendor/jquery/jquery.ba-hashchange-1.3.js",0).add("vendor/jquery/jquery.debounce-1.0.5.js",0).add("menu-resizer.js",1).add("cross_framing_protection.js",0).add("rte.js",1).add("vendor/tracekit.js",1).add("error_report.js",1).add("messages.php",0).add("config.js",1).add("doclinks.js",1).add("functions.js",1).add("navigation.js",1).add("indexes.js",1).add("common.js",1).add("page_settings.js",1).add("shortcuts_handler.js",1).add("vendor/codemirror/lib/codemirror.js",0).add("vendor/codemirror/mode/sql/sql.js",0).add("vendor/codemirror/addon/runmode/runmode.js",0).add("vendor/codemirror/addon/hint/show-hint.js",0).add("vendor/codemirror/addon/hint/sql-hint.js",0).add("vendor/codemirror/addon/lint/lint.js",0).add("codemirror/addon/lint/sql-lint.js",0).add("console.js",1);
$(function() {AJAX.fireOnload("whitelist.php");AJAX.fireOnload("vendor/sprintf.js");AJAX.fireOnload("keyhandler.js");AJAX.fireOnload("vendor/js.cookie.js");AJAX.fireOnload("menu-resizer.js");AJAX.fireOnload("rte.js");AJAX.fireOnload("vendor/tracekit.js");AJAX.fireOnload("error_report.js");AJAX.fireOnload("config.js");AJAX.fireOnload("doclinks.js");AJAX.fireOnload("functions.js");AJAX.fireOnload("navigation.js");AJAX.fireOnload("indexes.js");AJAX.fireOnload("common.js");AJAX.fireOnload("page_settings.js");AJAX.fireOnload("shortcuts_handler.js");AJAX.fireOnload("console.js");});
// ]]>
</script>

```

**What can we gather from this script?**

1. `token:"xxxx"`&#x20;
2. `PMA_VERSION:"4.9.5deb2"`
3. `auth_type:"cookie"`



From this, we gathered a token string, the PMA version, authentication type used in this application, and a username.

> Note: PMA -> PHP My Admin

**Looking for vulnerabilities relating to `PMA version 4.9.5`**.

The version of our target's _phpmyadmin_ falls outside the range of vulnerable versions, which exists before and after **4.9.5**.

_Eg. 4.x before 4.9.5_ and _5.x before 5.0.2_.&#x20;

{% embed url="https://github.com/advisories/GHSA-fcww-8wvc-38q9" %}

&#x20;
