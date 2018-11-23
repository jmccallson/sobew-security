package org.sobew.exceptions;

public class SecurityExpiredSessionException extends Exception{
  public SecurityExpiredSessionException(String message, Throwable throwable){
    super(message, throwable);
  }
}
