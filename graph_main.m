function [] = graph_main(name)
graph_CT([name '/results_CT']);
graph_IM([name '/results_CT']);
graph_RL([name '/results_RL']);