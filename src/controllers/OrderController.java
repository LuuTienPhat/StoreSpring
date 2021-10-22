package controllers;

import javax.transaction.Transactional;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Transactional

@RequestMapping("/admin/orders")
public class OrderController {
	
}
