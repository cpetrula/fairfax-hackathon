<quote-form>
	<div class="top-bar"></div>
	<div class="questions-container">
			<h2>Let's get you some options!</h2>
			<p class="help-text">Just start typing or use your voice.</p>
			<autocomplete name="business-type" placeholder="What kind of business do you have?" url="/data/businesses2.json" />
		</div>
	
	<div class="calculator-container">
		<div class="business-info">
			<h3>
				Here is some text that describes what you are seeing and what to do with it.
			</h3>
			Business Type: {business}<br />
			Province: {province}
		</div>
		<div id="calculator-components"></div>
	</div>


	<!--
	<p style="max-width: 500px" class="questions-container">
		Location test
		<location1></location1>
	</p>
	-->
	
	<div class="payment-container">
		<span class="monthly-payment-amount"></span> <span class="monthly-payment-text">per month</span>
		<button id="buy-now-btn" class="btn btn-danger" onclick={showBuyNow}>Buy Now</button>
	</div>
	<script>
		var _this=this;
		var generalLiabilitySlider;
		var entity;


		this.on('mount', function(){
			riot.update();
			$("[name=business-type]",_this.root).on("focus",function() {
				startQuote();
			})
			$("#test-btn").on("click",function() {
				increaseGeneralLiability();
			})
		})
		
		startQuote (result) {
			this.quoteForm2 = riot.mount('#calculator-components','quote-form2',{data:result})[0];
			entity=result;
			var params=result.result.parameters;
		
			this.business=params.business;
			this.province=params.Province;
			$("#hp-top,#hp-bottom,.questions-container").hide(500);
			$(".top-bar,.payment-container,.calculator-container",_this.root).show();	
			this.update();
		}

		increaseGeneralLiability () {
			var gls=generalLiabilitySlider;
			var step=gls.options.step;
			var currentVal=gls.options.from;
			gls.update({from:currentVal+step});
		}
		
		updatePaymentDisplay (payment) {
		    this.payment = payment;
			$(".monthly-payment-amount",_this.root).html("$"+payment);
		}

		showBuyNow() {
		    var coverages = this.quoteForm2.getValues();
			// console.log(coverages);

			var query = coverages.map((cov) => `&${cov.code}=${cov.value}`).reduce((a,b) => a + b);
			var url = "/buynow.html?" + query + "&PRICE=" + this.payment;

			console.log(url);
			window.location.href = url;
		}
	</script>
	<style scope>
		.top-bar {
			border-top:1px solid #555;
			padding-top:20px;
			margin-top:10px;
			display:none;
		}
		.questions-container {
				margin:0 50px 10px 50px;
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
		.business-info {
			padding: 10px;
			background-color: #4d97d6;
			color:#fff;
			border-radius: 3px;
			margin-bottom: 10px;
		}
		#buy-now-btn {
			margin-bottom:10px;
			margin-left:30px;
		}
		.monthly-payment-amount {
			font-size:28pt;
		}
		.calculator-container {
			display:none;
			padding:0 50px;
		}

	</style>
</quote-form>