
void validate_lan_ipaddr(FILE *param_1,undefined4 param_2,undefined4 *param_3)

{
  char *__s2;
  int iVar1;
  char *pcVar2;
  undefined *puVar3;
  char acStack_70 [20];
  undefined4 local_5c;
  char *local_58;
  undefined4 local_54;
  undefined **local_50;
  undefined4 local_4c;
  undefined4 local_48;
  undefined *local_44;
  undefined *local_40;
  undefined *local_3c;
  undefined *local_38;
  undefined *local_34;
  undefined *local_30;
  undefined *local_2c;
  undefined4 local_28;
  
  local_28 = DAT_004f44d8;
  local_44 = PTR_s_255.255.255.0_004f44bc;
  local_40 = PTR_s_255.255.255.128_004f44c0;
  local_3c = PTR_s_255.255.255.192_004f44c4;
  local_38 = PTR_s_255.255.255.224_004f44c8;
  local_34 = PTR_s_255.255.255.240_004f44cc;
  local_30 = PTR_s_255.255.255.248_004f44d0;
  local_2c = PTR_s_255.255.255.252_004f44d4;
  local_58 = "LAN Subnet Mask";
  local_50 = &local_44;
  local_5c = 0;
  local_54 = 0;
  local_4c = 0;
  local_48 = 0;
  puVar3 = PTR_s_255.255.255.128_004f44c0;
  __s2 = (char *)get_cgi(0x49d2c0);
  if (__s2 == (char *)0x0) {
    return;
  }
  get_merge_ipaddr(*param_3,acStack_70);
  iVar1 = valid_ipaddr(param_1,acStack_70,(int)param_3,puVar3);
  if (iVar1 == 0) {
    return;
  }
  iVar1 = valid_choice(param_1,__s2,(int)&local_5c,puVar3);
  if (iVar1 == 0) {
    return;
  }
  pcVar2 = (char *)nvram_get("lan_ipaddr");
  if (pcVar2 == (char *)0x0) {
    pcVar2 = "";
  }
  iVar1 = strcmp(pcVar2,acStack_70);
  if (iVar1 != 0) {
    unlink("/tmp/udhcpd.leases");
  }
  pcVar2 = (char *)nvram_get("lan_netmask");
  if (pcVar2 == (char *)0x0) {
    pcVar2 = "";
  }
  iVar1 = strcmp(pcVar2,__s2);
  if (iVar1 != 0) {
    unlink("/tmp/udhcpd.leases");
  }
  pcVar2 = (char *)nvram_get("lan_ipaddr");
  if (pcVar2 == (char *)0x0) {
    pcVar2 = "";
  }
  iVar1 = strcmp(acStack_70,pcVar2);
  if (iVar1 == 0) {
    pcVar2 = (char *)nvram_get("lan_netmask");
    if (pcVar2 == (char *)0x0) {
      pcVar2 = "";
    }
    iVar1 = strcmp(__s2,pcVar2);
    if (iVar1 == 0) {
      lan_ip_changed = 0;
      goto LAB_004286fc;
    }
  }
  lan_ip_changed = 1;
LAB_004286fc:
  nvram_set(*param_3,acStack_70);
  nvram_set("lan_netmask",__s2);
  return;
}

