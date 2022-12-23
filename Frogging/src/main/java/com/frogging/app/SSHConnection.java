package com.frogging.app;

import java.util.Properties;
import java.util.function.Consumer;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

public class SSHConnection {

	private static JSch jsch = new JSch();

	private String url = "106.10.46.53";
	private String username = "root";
	private String password = "T768HaNqFgN6q";
	private int port = 1025;
	private int iport = 8020;
	private int rport = 3306;

	private Session session;

	public SSHConnection() {
		try {
			session = jsch.getSession(username, url, port);
			session.setPassword(password);
			Properties config = new Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			session.connect();
			session.setPortForwardingL(iport, "127.0.0.1", rport);
			System.out.println("SSH 연결 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void shutdown() {
		if (session != null && session.isConnected()) {
			session.disconnect();
		}
	}
}
