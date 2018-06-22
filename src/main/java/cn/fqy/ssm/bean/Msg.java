package cn.fqy.ssm.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 响应状态，携带信息等
 * 状态码：100成功，200失败
 * @author acer
 *
 */
public class Msg {
	//状态码：100成功，200失败
	private int code;
	//状态信息
	private String msg;
	//可扩展信息
	private Map<String, Object> extend = new HashMap<String, Object>();
	
	//成功
	public static Msg success(){
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("处理成功！");
		return result;
	}
	//失败
	public static Msg fail(){
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("处理失败！");
		return result;
	}
	//可扩展处理
	public Msg add(String key, Object value){
		this.getExtend().put(key, value);
		return this;
	}
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
}
