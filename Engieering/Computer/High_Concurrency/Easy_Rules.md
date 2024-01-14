# $Easy\ Rules$

[TOC]

# Process

- 规则定义与创建（Rule）

  ```java
  #使用@Rule，@Condition @Action注解来示例：
  
  //规则定义
  @Rule(name = "weather rule", description = "if it rains then take an umbrella")
  public class WeatherRule {
  
      @Condition
      public boolean itRains(@Fact("rain") boolean rain) {
          return rain;
      }
  
      @Action
      public void takeAnUmbrella() {
          System.out.println("It rains, take an umbrella!");
      }
  }
  //规则创建
  WeatherRule weatherRule = new WeatherRule();
  Rules rules = new Rules();
  rules.register(weatherRule);
  ```

- 创建规则引擎（Engine）

  ```java
  // 创建规则引擎
  RulesEngine rulesEngine = new DefaultRulesEngine();
  ```

- 执行规则计算（fire）

  ```java
  rulesEngine.fire(rules, facts);
  ```

