module neuro.internals.synapse;

import neuro.internals.core;

class Synapse
{
	this(IFabric fabric, NeuronId owner, NeuronId neighbor, float connectionStrength)
	{
		_fabric = fabric;
		_owner = owner;
		_neighbor = neighbor;
		_connectionStrength = connectionStrength;
	}
	
	void dispose()
	{
		_fabric = null;
	}
	
	float neighborSignal()
	{
		return _fabric.neuron(_neighbor).signal();
	}
	
	float connectionStrength()
	{
		return _connectionStrength;
	}
	
	@property
	NeuronId owner()
	{
		return _owner;
	}
	
	@property
	NeuronId neighbor()
	{
		return _neighbor;
	}
	
	private:
	
	// Connection strength lies between -1 and 1. 
	// If < 0, inhibitory. If > 0, exitory
	IFabric _fabric;
	float _connectionStrength;
	NeuronId _owner;
	NeuronId _neighbor;
}