<quote-form>
	<div class="top-bar"></div>
	<div class="questions-container">
			<h2>Let's get you some options!</h2>
			<p class="help-text">Just start typing or use your voice.</p>
			<autocomplete name="business-type" placeholder="What kind of business do you have?" url="/data/businesses.json" />		
		</div>

	

	<div class="calculator-container">
							<div class="business-info">
			Business Type: {business}<br />
			Province: {province}
		</div>
<quote-form2></quote-form2>
	</div>


	<!--
	<p style="max-width: 500px" class="questions-container">
		Location test
		<location1></location1>
	</p>
	-->

	
	<div class="payment-container">
		<span class="monthly-payment-amount"></span> <span class="monthly-payment-text">per month</span>
		<button id="buy-now-btn" class="btn btn-danger">Buy Now</button>
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
			entity=result;
			$("#hp-top,#hp-bottom").hide(500);
			$(".top-bar,.payment-container,.calculator-container",_this.root).show();		
			
			_this.initializeSliders();
			_this.setDefaultValues();
		}
		
		initializeSliders () {
			$("[name=general-liability]").ionRangeSlider({
					type: "single",
					grid: true,
					min: 0,
					max: 1000000,
					step: 100000,
// 					from: 200,
// 					to: 800,
					prefix: "$",
					keyboard: true,
					onChange: function (data) {
						//console.log(data);
						_this.updatePaymentDisplay();
					},
					onUpdate: function (data) {
						//console.log(data);
						_this.updatePaymentDisplay();
					}
			});
			generalLiabilitySlider = $("[name=general-liability]").data("ionRangeSlider");
		}
		
		increaseGeneralLiability () {
			var gls=generalLiabilitySlider;
			var step=gls.options.step;
			var currentVal=gls.options.from;
			gls.update({from:currentVal+step});
		}
		
		setDefaultValues () {
			generalLiabilitySlider.update({from:200000});
		}
		
		calculatePayment () {
			var payment=0;	
// 			console.log("calc")
// 			console.log(generalLiabilitySlider)
// 			var generalLiabilityCoverage = generalLiabilitySlider.options.from;
			
// 			payment=generalLiabilityCoverage*.0002;
			var business=entity.result.parameters.business;
			var province=entity.result.parameters.Province;
			this.business=business;
			this.province=province;
			this.update();
			var c=getCoveragesForPrimaryName(business);
			payment = getMonthlyQuote(business,province,100000,c);
			return payment;
		}
		updatePaymentDisplay () {
			var payment=_this.calculatePayment();
			$(".monthly-payment-amount",_this.root).html("$"+payment);
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
		.calculator-container {
			display:none;
			padding:0 50px;
		}

	</style>
</quote-form>