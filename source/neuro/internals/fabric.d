module neuro.internals.fabric;

import neuro.internals.neuron;
import neuro.internals.core;
import std.random;

class Fabric : IFabric
{
	
	this()
	{
		_tick = 0;
	}
	
	void advance()
	{
		_tick++;
		foreach(n; _neurons.byValue())
		{
			n.update(_tick);
		}
	}
	
	void integrate()
	{
		foreach(n; _neurons.byValue())
		{
			n.integrate();
		}
	}
	
	void attach(Neuron n)
	{
		n.attach(this);
		_neurons[n.id] = n;
	}
	
	void detach(Neuron n)
	{
		if (n.isAttached(this))
		{
			n.detach();
			_neurons.remove(n.id);
		}
		
	}
	
	Neuron neuron(NeuronId id)
	{
		return _neurons[id];
	}
	
	void shuffle(float connectionFactor = 0.35f)
	{
		// Connect each neuron to 30% of the other available neurons, randomly
		int sampleSize = cast(int)(connectionFactor * cast(float)_neurons.length);
		for (int j = 0; j < _neurons.length; j++)
		{
			Neuron n = _neurons[j];
			Neuron neighbor;
			for(int i = 0; i < sampleSize; i++)
			{
				int cand;
				do {
					cand = uniform(0, cast(int)_neurons.length);
				} while (cand == j);
				neighbor = _neurons[cand];
				n.connect(neighbor, uniform(-1.0f, 1.0f));
			}	
		}
	}
	
	void printDebug()
	{
		foreach (Neuron n; _neurons)
		{
			n.writeDebugData();
		}
	}
	
	private:
	
	int _tick;
	Neuron[NeuronId] _neurons;
	
}