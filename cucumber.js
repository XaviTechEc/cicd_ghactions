const common = [
	'--require-module ts-node/register', // Load TypeScript module
];

const test_backend = [
	...common,
	'tests/features/**/*.feature',
	'--require tests/features/step_definitions/*.steps.ts',
].join(' ');

module.exports = {
	test_backend,
};
