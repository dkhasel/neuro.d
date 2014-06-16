import std.stdio;

import neuro.d;
import std.random;

void main()
{
	
	auto f = new Fabric();
	Neuron n;
	for (int i = 0; i < 10; i++)
	{
		n = new Neuron(i, uniform(0.0f, 3.3f));
		f.attach(n);		
	}
	
	f.shuffle(1.0f);
	f.printDebug();
}
