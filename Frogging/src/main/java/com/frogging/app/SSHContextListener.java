package com.frogging.app;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class SSHContextListener implements ServletContextListener{

	private SSHConnection sshConnection;
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("init start!");
		try {
			sshConnection = new SSHConnection();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("init destory!");
		try {
			sshConnection.shutdown();
			System.out.println("shutdown");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
