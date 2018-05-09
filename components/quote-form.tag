<quote-form>
	<div class="top-bar"></div>
	<div class="questions-container">
			<h2>Let's get you some options!</h2>
			<p class="help-text">Just start typing or use your voice.</p>
			<!--
			<input type="text" name="business-type" placeholder="What kind of business do you have?" class="form-control"/>
			-->
			<autocomplete name="business-type" placeholder="What kind of business do you have?" url="/data/businesses.json" />
	</div>
	
	<div class="payment-container">
		<span class="monthly-payment-amount">$350</span> <span class="monthly-payment-text">per month</span>
		<button id="buy-now-btn" class="btn btn-danger">Buy Now</button>
	</div>
	<script>
		var _this=this;
		this.on('mount', function(){
			$("[name=business-type]",_this.root).on("focus",function() {
				startQuote();
			})
		})
		
		function startQuote () {
			$("#hp-top,#hp-bottom").hide(500);
			$(".top-bar,.payment-container",_this.root).show();		
		}
	</script>
	<style scope>
		.top-bar {
			border-top:1px solid #555;
			padding-top:20px;
			margin-top:10px;
			display:none;
		}
		.payment-container {
			position:fixed;
			bottom:0;
			height:60px;
			padding:0 50px;
			width:100%;
			background-color:#e6e6e6;
			display:none;
		}
		#buy-now-btn {
			margin-bottom:10px;
			margin-left:30px;
		}
		.monthly-payment-amount {
			font-size:28pt;
		}
	</style>
</quote-form>