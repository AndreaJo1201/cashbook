package vo;

public class Comment {
	private int commentNo;
	private int helpNo;
	private String commnetMemo;
	private String memberId;
	private String updatedate;
	
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getHelpNo() {
		return helpNo;
	}
	public void setHelpNo(int helpNo) {
		this.helpNo = helpNo;
	}
	public String getCommnetMemo() {
		return commnetMemo;
	}
	public void setCommnetMemo(String commnetMemo) {
		this.commnetMemo = commnetMemo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	private String createdate;
	
}
