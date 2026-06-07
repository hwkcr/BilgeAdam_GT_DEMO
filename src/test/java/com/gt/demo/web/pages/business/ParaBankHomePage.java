package com.gt.demo.web.pages.business;

import com.gt.demo.web.base.BaseWebPage;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class ParaBankHomePage extends BaseWebPage {
  private static final By USERNAME = By.name("username");
  private static final By PASSWORD = By.name("password");
  private static final By LOGIN_BUTTON = By.cssSelector("input.button[value='Log In']");
  private static final By REGISTER_LINK = By.linkText("Register");
  private static final By LOGIN_ERROR = By.cssSelector("div#showError p.error");
  private static final By LOGOUT_LINK = By.linkText("Log Out");

  public ParaBankHomePage(WebDriver driver) {
    super(driver);
  }

  public void open(String baseUrl) {
    driver.get(baseUrl + "/index.htm");
  }

  public void login(String username, String password) {
    type(USERNAME, username);
    type(PASSWORD, password);
    click(LOGIN_BUTTON);
  }

  public void goToRegister() {
    click(REGISTER_LINK);
  }

  public String loginError() {
    String visibleError = driver.findElements(LOGIN_ERROR).stream()
        .map(element -> element.getText().trim())
        .filter(text -> !text.isBlank())
        .findFirst()
        .orElse("");
    if (!visibleError.isBlank()) {
      return visibleError;
    }

    String pageSource = driver.getPageSource().toLowerCase();
    if (pageSource.contains("an internal error has occurred")) {
      return "An internal error has occurred and has been logged.";
    }
    if (pageSource.contains("could not be verified")) {
      return "could not be verified";
    }
    if (pageSource.contains("error")) {
      return "Login page contains error text.";
    }
    return "";
  }

  public String dashboardTitle() {
    return driver.getTitle();
  }

  public boolean isLoggedIn() {
    return !driver.findElements(LOGOUT_LINK).isEmpty();
  }
}
