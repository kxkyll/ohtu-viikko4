import ohtu.*
import ohtu.authentication.*
import org.openqa.selenium.*
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

description """A new user account can be created 
              if a proper unused username 
              and a proper password are given"""

scenario "creation succesfull with correct username and password", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();       
    }
 
    when 'a valid username and password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("itakitak");
        element = driver.findElement(By.name("password"));
        element.sendKeys("2itakitak");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("2itakitak");
        element = driver.findElement(By.name("add"));
        element.submit();
      
    }

    then 'new user is registered to system', {
        driver.getPageSource().contains("Welcome").shouldBe true
      
    }
}

scenario "can login with succesfully generated account", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();       
    }
 
    when 'a valid username and password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("jokujoku");
        element = driver.findElement(By.name("password"));
        element.sendKeys("salasana3");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("salasana3");
        element = driver.findElement(By.name("add"));
        element.submit();
        element = driver.findElement(By.partialLinkText("continue"));   
        element.click();  
    }

    then  'new credentials allow logging in to system', {
        driver.getPageSource().contains("Welcome to Ohtu Application").shouldBe true
      
    }
}

scenario "creation fails with correct username and too short password", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();  
      
	}
    when 'a valid username and too short password are entered',{
        element = driver.findElement(By.name("username"));
        element.sendKeys("minnami");
        element = driver.findElement(By.name("password"));
        element.sendKeys("3");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("3");
        element = driver.findElement(By.name("add"));
        element.submit();
              
	}
    then 'new user is not be registered to system', {
        driver.getPageSource().contains("length greater or equal to 8").shouldBe true
	}
}

scenario "creation fails with correct username and pasword consisting of letters", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();  
       
	}
    when 'a valid username and password consisting of letters are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("jokuheppu");
        element = driver.findElement(By.name("password"));
        element.sendKeys("salasanas");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("salasanas");
        element = driver.findElement(By.name("add"));
        element.submit();
      
	}
    then 'new user is not be registered to system', {
      driver.getPageSource().contains("must contain one character that is not a letter").shouldBe true
	}
}

scenario "creation fails with too short username and valid pasword", {
    given 'command new user is selected',{
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();  
      
	}
    when 'a too sort username and valid password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("jok");
        element = driver.findElement(By.name("password"));
        element.sendKeys("salasana4");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("salasana4");
        element = driver.findElement(By.name("add"));
        element.submit();
      
	}
    then 'new user is not be registered to system', {
    driver.getPageSource().contains("length 5-10").shouldBe true
      
	}
}

scenario "creation fails with already taken username and valid pasword", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();  
	
	}
    when 'a already taken username and valid password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("itakitak");
        element = driver.findElement(By.name("password"));
        element.sendKeys("2itakitak");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("2itakitak");
        element = driver.findElement(By.name("add"));
        element.submit();
      
	}
    then 'new user is not be registered to system', {
        driver.getPageSource().contains("username or password invalid").shouldBe true
      	}
}

scenario "can not login with account that is not succesfully created", {
    given 'command new user is selected', {
        driver = new HtmlUnitDriver();
        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();  
	
	}
    when 'a invalid username/password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("ita");
        element = driver.findElement(By.name("password"));
        element.sendKeys("salasana3");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("salasana3");
        element = driver.findElement(By.name("add"));
        element.submit();

        driver.get("http://localhost:8080");
        element = driver.findElement(By.linkText("login"));       
        element.click();  
        element = driver.findElement(By.name("username"));
        element.sendKeys("ita");
        element = driver.findElement(By.name("password"));
        element.sendKeys("salasana3");
        element.submit(); 
      
	}
    then  'new credentials do not allow logging in to system', {
	driver.getPageSource().contains("wrong username or password").shouldBe true
	}
}
