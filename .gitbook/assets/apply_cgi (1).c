undefined4
apply_cgi(FILE *param_1,undefined4 param_2,undefined4 param_3,undefined4 param_4,undefined4 param_5,
         char *param_6,char *param_7)

{
  char *pcVar1;
  int iVar2;
  char *__s1;
  char *pcVar3;
  FILE *__stream;
  undefined4 uVar4;
  undefined **ppuVar5;
  undefined1 *puVar6;
  uint __seconds;
  char local_838;
  undefined1 auStack_837 [2047];
  char *local_38;
  int local_34;
  int local_30;
  
  pcVar1 = (char *)get_cgi(0x49f270);
  if (pcVar1 == (char *)0x0) {
    pcVar1 = "0";
  }
  local_30 = atoi(pcVar1);
  pcVar1 = (char *)get_cgi(0x49f188);
  if (pcVar1 == (char *)0x0) {
    pcVar1 = "1";
  }
  local_34 = atoi(pcVar1);
  local_38 = (char *)get_cgi(0x49f27c);
  error_value = 0;
  pcVar1 = (char *)get_cgi(0x49f288);
  if (pcVar1 == (char *)0x0) {
    pcVar1 = "";
  }
  iVar2 = strcmp(pcVar1,"gozila_cgi");
  if (iVar2 == 0) {
    gozila_cgi(param_1);
    return 1;
  }
  __s1 = (char *)get_cgi(0x49edc0);
  if (__s1 == (char *)0x0) {
    __s1 = "";
    if (param_7 != (char *)0x0) goto LAB_00421bc0;
LAB_00421d74:
    puVar6 = (undefined1 *)0x0;
    __seconds = 0;
  }
  else {
    if (param_7 == (char *)0x0) goto LAB_00421d74;
LAB_00421bc0:
    if (param_6 != (char *)0x0) {
      iVar2 = strcmp(param_6,"tmBlock.cgi");
      if (iVar2 == 0) {
        local_838 = '\0';
        memset(auStack_837,0,0x7ff);
        iVar2 = get_cgi(0x4a2600);
        sprintf(&local_838,"http://%s",iVar2);
        nvram_set("TM_block_url",&local_838);
        iVar2 = get_cgi(0x4a35cc);
        nvram_set("TM_block_index",iVar2);
        iVar2 = get_cgi(0x4a1474);
        nvram_set("TM_block_hwaddr",iVar2);
        pcVar1 = (char *)get_cgi(0x49f2ec);
        if ((pcVar1 == (char *)0x0) || (iVar2 = strcmp(pcVar1,"1"), iVar2 != 0)) {
          do_ej("tmWTPBlock.asp",param_1);
        }
        else {
          do_ej("tmPCBlock.asp",param_1);
        }
        wfflush(param_1);
        return 1;
      }
      iVar2 = strcmp(param_6,"hndBlock.cgi");
      if (iVar2 == 0) {
        local_838 = '\0';
        memset(auStack_837,0,0x7ff);
        iVar2 = get_cgi(0x4a2600);
        sprintf(&local_838,"http://%s",iVar2);
        nvram_set("hnd_block_url",&local_838);
        iVar2 = get_cgi(0x49bfd0);
        nvram_set("hnd_block_policy",iVar2);
        iVar2 = get_cgi(0x4a1474);
        nvram_set("hnd_block_mac",iVar2);
        iVar2 = get_cgi(0x49f6a0);
        nvram_set("hnd_block_ip",iVar2);
        pcVar1 = (char *)get_cgi(0x49f2ec);
        if ((pcVar1 == (char *)0x0) || (iVar2 = strcmp(pcVar1,"0"), iVar2 != 0)) {
          do_ej("BlockSite.asp",param_1);
        }
        else {
          do_ej("BlockTime.asp",param_1);
        }
        nvram_set("hnd_password_deny",&DAT_0049ea84);
        wfflush(param_1);
        return 1;
      }
    }
    iVar2 = check_wl_test();
    if ((iVar2 != 0) || (pcVar3 = check_led_test(), pcVar3 != (char *)0x0)) goto LAB_00421d74;
    iVar2 = check_wps_button_test(param_1,param_7,param_3,param_4);
    if (iVar2 != 0) {
      return 1;
    }
    iVar2 = set_wl_security_mode();
    if (iVar2 != 0) {
      return 1;
    }
    pcVar1 = (char *)get_cgi(0x49f35c);
    if (pcVar1 == (char *)0x0) {
      pcVar1 = (char *)get_cgi(0x49f36c);
      if (pcVar1 == (char *)0x0) {
        pcVar1 = "";
      }
      iVar2 = strcmp(pcVar1,"Apply");
      if (((iVar2 == 0) || (iVar2 = strcmp(pcVar1,"tmUnblock"), iVar2 == 0)) ||
         (iVar2 = strcmp(pcVar1,"hndUnblock"), iVar2 == 0)) {
        ppuVar5 = &variables;
        do {
          pcVar3 = (char *)get_cgi((ACTION)*ppuVar5);
          if (pcVar3 != (char *)0x0) {
            if (((*pcVar3 == '\0') && (ppuVar5[4] != (undefined *)0x0)) ||
               ((code *)ppuVar5[2] == (code *)0x0)) {
              nvram_set(*ppuVar5,pcVar3,ppuVar5,nvram_set);
            }
            else {
              (*(code *)ppuVar5[2])(param_1,pcVar3);
            }
          }
          ppuVar5 = ppuVar5 + 6;
        } while (ppuVar5 != &gozila_actions);
        ppuVar5 = handle_apply_action(__s1);
        if (ppuVar5 == (undefined **)0x0) {
          nvram_set("action_service",&DAT_004ae85c);
          puVar6 = (undefined1 *)0x2;
          __seconds = 1;
        }
        else {
          __stream = fopen("/dev/console","w");
          if (__stream != (FILE *)0x0) {
            fprintf(__stream,"submit_button=[%s] service=[%s] sleep_time=[%d] action=[%d]\n",
                    *ppuVar5,ppuVar5[1],ppuVar5[2],ppuVar5[3]);
            fclose(__stream);
          }
          if (ppuVar5[3] == (undefined *)0x3) {
            nvram_set("action_service",ppuVar5[1]);
          }
          else {
            nvram_set("action_service",&DAT_004ae85c);
          }
          pcVar3 = *ppuVar5;
          puVar6 = ppuVar5[3];
          iVar2 = strcmp(pcVar3,"index");
          if (iVar2 == 0) {
            nvram_set("DHCP6_REBIND_INSTEAD_OF_SOLICIT",&DAT_004a22b4);
          }
          else {
            iVar2 = strcmp(pcVar3,"index_ipv6");
            if (iVar2 == 0) {
              nvram_unset("DHCP6_REBIND_INSTEAD_OF_SOLICIT");
            }
          }
          __seconds = 0;
          if ((code *)ppuVar5[4] != (code *)0x0) {
            (*(code *)ppuVar5[4])(param_1);
            __seconds = 0;
          }
        }
        if (local_34 != 0) {
          sys_commit();
        }
      }
      else {
        iVar2 = strncmp(pcVar1,"Restore",7);
        if (iVar2 == 0) {
          nvram_set("restore_defaults",&DAT_004a22b4);
          puVar6 = &DAT_00000001;
          __seconds = 0;
        }
        else {
          uVar4 = 7;
          iVar2 = strncmp(pcVar1,"Reboot",7);
          if (iVar2 == 0) {
            puVar6 = &DAT_00000001;
            __seconds = 0;
          }
          else {
            error_value = 1;
            wfputs("<!--",param_1);
            wfprintf(param_1,"Invalid Value!<br>",uVar4,param_4);
            wfputs("-->",param_1);
            puVar6 = (undefined1 *)0x0;
            wfflush(param_1);
            __seconds = 0;
          }
        }
      }
    }
    else {
      iVar2 = atoi(pcVar1);
      if ((iVar2 != 0) && (iVar2 != 1)) goto LAB_00421d74;
      nvram_set("skip_amd_check",pcVar1);
      puVar6 = (undefined1 *)0x0;
      __seconds = 0;
      sys_commit();
    }
  }
  nvram_set("reboot_flag",&DAT_0049ea84);
  nvram_set("fadef_flag",&DAT_0049ea84);
  if (error_value == 0) {
    iVar2 = get_cgi(0x49f43c);
    if (iVar2 == 0) {
      iVar2 = get_cgi(0x49f480);
      if (iVar2 == 0) {
        if ((lan_ip_changed == 0) && (local_30 == 0)) {
          iVar2 = strncmp(pcVar1,"Restore",7);
          if (iVar2 == 0) {
            nvram_set("reboot_flag",&DAT_004a22b4);
            nvram_set("fadef_flag",&DAT_004a22b4);
          }
        }
        else {
          nvram_set("reboot_flag",&DAT_004a22b4);
        }
        iVar2 = strcmp(__s1,"Upgrade");
        if (iVar2 == 0) {
          do_ej("Success_Safe_upgrade.asp",param_1);
        }
        else {
          do_ej("Success.asp",param_1);
        }
      }
      else {
        do_ej("Redirect.asp",param_1);
        nvram_set("hnd_unblock_url",&DAT_004ae85c);
      }
    }
    else {
      iVar2 = strcmp(__s1,"Upgrade");
      if (iVar2 == 0) {
        do_ej("Success_Safe_upgrade.asp",param_1);
      }
      else {
        do_ej("Success_s.asp",param_1);
      }
    }
  }
  else {
    iVar2 = get_cgi(0x49f43c);
    if (iVar2 == 0) {
      do_ej("Fail.asp",param_1);
    }
    else {
      do_ej("Fail_s.asp",param_1);
    }
  }
  wfflush(param_1);
  nvram_unset("reboot_flag");
  nvram_unset("fadef_flag");
  nvram_set("upnp_wan_proto",&DAT_004ae85c);
  if ((lan_ip_changed != 0) || (local_30 != 0)) {
    puVar6 = &DAT_00000001;
  }
  if (local_38 == (char *)0x0) {
LAB_00422244:
    generate_key0 = 0;
    generate_key1 = 0;
    if (puVar6 != (undefined1 *)0x2) {
      if (puVar6 == &DAT_00000001) {
        kill(1,0xf);
      }
      else if (puVar6 == (undefined1 *)0x3) {
        kill(1,0x10);
      }
      goto LAB_00421ed4;
    }
  }
  else {
    iVar2 = strcmp(local_38,"nothing");
    if (iVar2 == 0) {
      generate_key0 = 0;
      generate_key1 = 0;
      goto LAB_00421ed4;
    }
    iVar2 = strcmp(local_38,"restart");
    if (iVar2 != 0) goto LAB_00422244;
  }
  generate_key0 = 0;
  generate_key1 = 0;
  kill(1,1);
LAB_00421ed4:
  sleep(__seconds);
  return 1;
}