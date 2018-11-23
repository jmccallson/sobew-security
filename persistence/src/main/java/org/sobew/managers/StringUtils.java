package org.sobew.managers;

public class StringUtils {
  //making sure it is all static
  private StringUtils(){}

  public static boolean stringNotEmpty(String param){
    return param != null && param.trim().isEmpty();
  }
}
