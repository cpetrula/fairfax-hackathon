<quote-form>
	<div class="top-bar"></div>
	<div class="questions-container">
			<h2>Let's get you some options!</h2>
			<p class="help-text">Just start typing or use your voice.</p>
			<input type="text" name="business-type" placeholder="What kind of business do you have?" class="form-control"/>
	</div>
	<div class="calculator-container">
		<label>General Liability Coverage</label>
		<input name="general-liability" />
			<button id="test-btn">
		Test to increase liability insurance
	</button>
	</div>

	
	<div class="payment-container">
		<span class="monthly-payment-amount"></span> <span class="monthly-payment-text">per month</span>
		<button id="buy-now-btn" class="btn btn-danger">Buy Now</button>
	</div>
	<script>
		var _this=this;
		var generalLiabilitySlider;
		this.on('mount', function(){
			$("[name=business-type]",_this.root).on("focus",function() {
				startQuote();
			})
			$("#test-btn").on("click",function() {
				increaseGeneralLiability();
			})
		})
		
		function startQuote () {
			$("#hp-top,#hp-bottom").hide(500);
			$(".top-bar,.payment-container,.calculator-container",_this.root).show();		
			
			initializeSliders();
			setDefaultValues();
		}
		
		function initializeSliders () {
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
						updatePaymentDisplay();
					},
					onUpdate: function (data) {
						//console.log(data);
						updatePaymentDisplay();
					}
			});
			generalLiabilitySlider = $("[name=general-liability]").data("ionRangeSlider");
		}
		
		function increaseGeneralLiability () {
			var gls=generalLiabilitySlider;
			var step=gls.options.step;
			var currentVal=gls.options.from;
			gls.update({from:currentVal+step});
		}
		
		function setDefaultValues () {
			generalLiabilitySlider.update({from:200000});
		}
		
		function calculatePayment () {
			var payment=0;	
			console.log("calc")
			console.log(generalLiabilitySlider)
			var generalLiabilityCoverage = generalLiabilitySlider.options.from;
			
			payment=generalLiabilityCoverage*.0002;
			return payment;
		}
		function updatePaymentDisplay () {
			var payment=calculatePayment();
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