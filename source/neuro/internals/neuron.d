module neuro.internals.neuron;

import std.container;
import std.stdio;
import neuro.internals.synapse;
import neuro.internals.core;

class Neuron
{
	
	this(NeuronId id, float initialSignal)
	{
		_id = id;
		_currentValue = initialSignal;
	}
	
	@property
	NeuronId id()
	{
		return _id;
	}
	
	void attach(IFabric fabric)
	{
		_fabric = fabric;
	}
	
	bool isAttached(IFabric fabric)
	{
		return _fabric == fabric;
	}
	
	void detach()
	{
		_fabric = null;
	}
	
	void update(int tick)
	{
		_lastTick = tick;
	}
	
	void integrate()
	{
		
	}
	
	float signal()
	{
		return _currentValue;
	}
	
	void clearConnections()
	{
		while(!_synapses.empty())
		{
			Synapse s = _synapses.back();
			_synapses.removeBack();
			s.dispose();
		}
	}
	
	void connect(Neuron neighbor, float initialStrength)
	{
		auto s = new Synapse(_fabric, this.id, neighbor.id, initialStrength);
		_synapses.insert(s);
	}
	
	void writeDebugData()
	{
		writefln("Neuron %s", _id);
		foreach(Synapse s; _synapses)
		{
			writefln("Synapse [%s, %s], conn strength: %s, neighbor signal: %s", s.owner, s.neighbor, s.connectionStrength(), s.neighborSignal());
		}
	}
	
	private:
	NeuronId _id;
	Array!Synapse _synapses;
	
	IFabric _fabric;
	
	float _currentValue;
	int _lastTick;
	
	
}