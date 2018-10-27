
// initialize ingredients to base, personal pizza
var size = "Personal";
var sizeObj = {
  Personal: 6,
  Medium: 10,
  Large: 14,
  "X-Large": 16
};
var sizeCost = 6;

var crust = "Plain";
var sauce = "Marinara";
var cheese = "Regular";

var meats = [];
var meatCost = 0;
var veggies = [];
var veggieCost = 0;

var totalRef = document.getElementById("total"); 
var total = Number(totalRef.textContent.substring(totalRef.textContent.indexOf("$")+1,totalRef.textContent.length));


// Detect when size is selected and re-estimate total
$(".size").on("change", function(){
  total -= sizeCost;  
  size = document.querySelector("input[name=size]:checked").value;
  sizeCost = sizeObj[size];
  total += sizeCost;
  totalRef.innerHTML = "Total: $" + total.toFixed(2);
});


// Detect when crust is selected and re-estimate total if needed
$(".crust").on("change", function(){
  newCrust = document.querySelector("input[name=crust]:checked").value;
  if(newCrust=="Cheese Stuffed"){
    total += 3;
  } else {
    if(crust=="Cheese Stuffed") {
      total -= 3;
    }
  }
  crust=newCrust;
  totalRef.innerHTML = "Total: $" + total.toFixed(2);
});


// Record sauce value selected
$(".sauce").on("change", function(){
  sauce = document.querySelector("input[name=sauce]:checked").value;
})


// Detect when cheese is selected and re-estimate total if needed
$(".cheese").on("change", function(){
  newCheese = document.querySelector("input[name=cheese]:checked").value;
  if(newCheese=="Extra"){
    total += 3;
  } else {
    if(cheese=="Extra") {
      total -= 3;
    }
  }
  cheese=newCheese;
  totalRef.innerHTML = "Total: $" + total.toFixed(2);
});

// Function to calculate cost of extra ingredients
function calculateIngredientCost(ingredientsArray) {
  if(ingredientsArray.length<=1) {
    return 0;
  } else {
    return ingredientsArray.length-1;
  }
}

// Detect when meat is selected and re-estimate total
$(".meat-ingredients").on('change', function(){
  meats = $("input[name=meat]:checked").map(function() {return this.value;}).get();
  newCost = calculateIngredientCost(meats);
  if(newCost!=meatCost) {
    total = total - meatCost + newCost;
    totalRef.innerHTML = "Total: $" + total.toFixed(2); 
    meatCost = newCost;
  }
});

// Detect when veggie is selected and re-estimate total
$(".veggie-ingredients").on('change', function(){
  veggies = $("input[name=veggie]:checked").map(function() {return this.value;}).get();
  newCost = calculateIngredientCost(veggies);
  if(newCost!=veggieCost) {
    total = total - veggieCost + newCost;
    totalRef.innerHTML = "Total: $" + total.toFixed(2); 
    veggieCost = newCost;
  }
});

// Generate itemized receipt when order is placed
function placeOrder() {
  // Unhide table
  var tableRef = document.getElementById("order-table");
  tableRef.style.display = "table";
  
  // Display pizza elements
  document.getElementById("order-size").innerHTML = "<td>" + size + "</td><td>" + sizeCost.toFixed(2) + "</td>";
  document.getElementById("order-crust").innerHTML = "<td>" + crust + "</td><td>" + (crust=="Cheese Stuffed" ? "3.00" : "0.00") + "</td>";
  document.getElementById("order-sauce").innerHTML = "<td>" + sauce + "</td><td>0.00</td>";
  document.getElementById("order-cheese").innerHTML = "<td>" + cheese + "</td><td>" + (cheese=="Extra" ? "3.00" : "0.00") + "</td>";
  document.getElementById("order-meat").innerHTML = "<td>" + (meats.length===0 ? "None" : meats.join(", ")) + "</td><td>" + meatCost.toFixed(2) + "</td>";
  document.getElementById("order-veggies").innerHTML = "<td>" + (veggies.length===0 ? "None" : veggies.join(", ")) + "</td><td>" + veggieCost.toFixed(2) + "</td>";
  document.getElementById("order-total").innerHTML = "<td>Total:</td><td>" + total.toFixed(2) + "</td>";
}




// Reset selections
function resetOrder() {
  // Hide table
  var tableRef = document.getElementById("order-table");
  tableRef.style.display = "none";
  
  // Reset size  
  var sizeVals = document.getElementsByName("size");
  for(var i=0; i<sizeVals.length;i++) {
    sizeVals[i].value=="Personal" ? sizeVals[i].checked=true : sizeVals[i].checked=false;
  }
  size="Personal";
  sizeCost=6;
  
  // Reset crust
  var crustVals = document.getElementsByName("crust");
  for(var i=0; i<crustVals.length;i++) {
    crustVals[i].value=="Plain" ? crustVals[i].checked=true : crustVals[i].checked=false;
  }
  crust="Plain";
  
  // Reset crust
  var sauceVals = document.getElementsByName("sauce");
  for(var i=0; i<sauceVals.length;i++) {
    sauceVals[i].value=="Marinara" ? sauceVals[i].checked=true : sauceVals[i].checked=false;
  }
  sauce="Marinara";
  
  // Reset cheese
  var cheeseVals = document.getElementsByName("cheese");
  for(var i=0; i<cheeseVals.length;i++) {
    cheeseVals[i].value=="Regular" ? cheeseVals[i].checked=true : cheeseVals[i].checked=false;
  }
  cheese="Regular";
  
  // Reset meats and veggies
  $('input[type=checkbox]').prop('checked',false);
  meats = [];
  meatCost = 0;
  veggies = [];
  veggieCost = 0;
  
  // Reset total cost
  total = 6;
  totalRef.innerHTML = "Total: $" + total.toFixed(2); 
}




