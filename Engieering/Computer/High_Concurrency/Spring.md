# Spring

[TOC]

## Bean 的生命周期

实例化 -> 属性赋值 -> 初始化 -> 销毁

<img src="assets/format,png.png" alt="img" style="zoom: 30%;" />



## Architecture of MVC (Model-View-Controller)

* Model
  * Entity: represent the data objects in the application. They typically correspond to database tables or other data sources, and they encapsulate the data and business logic associated with those entities.
  * Data access objects (DAO): responsible for data access and provide an abstraction layer for interacting with the underlying data storage, such as a database. They encapsulate the logic for querying, inserting, updating, and deleting data.
  * Service: implement the business logic and act as intermediaries between the controllers and the DAO layer. They coordinate multiple DAO operations and apply business rules on the data.
  * Utility: provide helper methods or utility functions used by the Model components.
* Controller  
  The Controller acts as an intermediary between the Model and the View. 
* View

## Annotations
1. `@SpringBootApplication` - 组合注解，用于启动Spring应用程序的自动配置等。

2. `@Component` - 表示一个类作为组件类，并告诉Spring需要为这个类创建bean。

3. `@Service` - 标记服务层的组件。用于将一个类标记为服务层组件，表示该类负责处理业务逻辑、协调数据访问和执行其他服务操作。

4. `@Repository` - 标记数据访问层组件，即DAO层组件。

5. `@Controller` - 标记控制层组件，如Spring MVC控制器。

6. `@RestController` - 用于创建RESTful控制器，它结合了`@Controller`和`@ResponseBody`。

7. `@RequestMapping` - 用于映射web请求到Spring Controller的方法上。

8. `@GetMapping`, `@PostMapping`, `@PutMapping`, `@DeleteMapping`, `@PatchMapping` - 这些是`@RequestMapping`的专化版本，用于处理HTTP GET, POST, PUT, DELETE, PATCH请求。

9. `@Autowired` - 自动装配依赖关系。

10. `@Qualifier` - 当有多个相同类型的bean时，用于指定需要装配哪一个。

11. `@Value` - 用于注入属性文件中的值。

12. `@Configuration` - 表示一个类定义了一个或多个`@Bean`方法，并且可能会被Spring容器用来构建bean定义，初始化Spring环境。

13. `@Bean` - 表示一个方法产生一个bean要由Spring容器管理。

14. `@Profile` - 指定某些bean只有在特定的profile被激活时才会注册。

15. `@Scope` - 定义bean的作用域。

16. `@Lazy` - 标记在bean的懒加载时使用。

17. `@Required` - 表明bean的属性必须在配置时设置，通过一个显式的bean属性值或通过自动装配。

18. `@Transactional` - 声明事务的边界。

19. `@EnableAutoConfiguration` - 告诉Spring Boot自动配置你的应用程序。

20. `@Import` - 用于导入其他配置类。

21. `@Aspect` - 标记一个类为切面类。

22. `@EnableAspectJAutoProxy` - 开启AspectJ自动代理。

23. `@ExceptionHandler` - 用于定义方法处理异常。

24. `@PathVariable` - 用于将请求URL中的模板变量映射到方法的参数上。

25. `@RequestParam` - 用于将请求参数区数据映射到方法的参数上。

26. `@RequestBody` - 允许将HTTP请求体绑定到方法的参数上。

27. `@ResponseBody` - 告诉Spring使用消息转换器返回数据作为HTTP响应体。

28. `@Valid` - 用于验证标注了约束条件的Bean属性。
