
undefined4 get_merge_ipaddr(undefined4 param_1,char *param_2)

{
  char *__src;
  size_t sVar1;
  int iVar2;
  char acStack_48 [32];
  
  *param_2 = '\0';
  iVar2 = 0;
  while( true ) {
    snprintf(acStack_48,0x1e,"%s_%d",param_1,iVar2);
    __src = (char *)get_cgi((ACTION)acStack_48);
    if (__src == (char *)0x0) {
      __src = "0";
    }
    strcat(param_2,__src);
    if (iVar2 == 3) break;
    iVar2 = iVar2 + 1;
    sVar1 = strlen(param_2);
    param_2[sVar1] = '.';
    (param_2 + sVar1)[1] = '\0';
    if (iVar2 == 4) {
      return 1;
    }
  }
  return 1;
}

