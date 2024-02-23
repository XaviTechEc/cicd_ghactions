import { Given, When, Then } from '@cucumber/cucumber';
import { Calculator } from '../../../src/calculator';

import assert from 'assert';

let calculator: Calculator;
let sum: number;

Given('A function to calculate the sum', function () {
	// Write code here that turns the phrase above into concrete actions
	calculator = new Calculator();
});

When('A user enter {int} and {int}', function (num1: number, num2: number) {
	// When('A user enter {int} and {float}', function (int, float) {
	// When('A user enter {float} and {int}', function (float, int) {
	// When('A user enter {float} and {float}', function (float, float2) {
	// Write code here that turns he phrase above into concrete actions
	sum = calculator.add(num1, num2);
});

Then('the result should be {int}', function (result: number) {
	// Then('the result should be {float}', function (float) {
	// Write code here that turns the phrase above into concrete actions
	assert.equal(sum, result);
});
