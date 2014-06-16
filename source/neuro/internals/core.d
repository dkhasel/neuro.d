module neuro.internals.core;

import neuro.internals.neuron;

alias NeuronId = int;

interface IFabric
{
	Neuron neuron(NeuronId id);
}