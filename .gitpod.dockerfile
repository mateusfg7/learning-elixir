FROM gitpod/workspace-full

USER root

RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
RUN sudo apt-get update
RUN sudo apt-get install esl-erlang
RUN sudo apt-get install elixir
RUN elixir --version && rm erlang-solutions_2.0_all.deb

USER gitpod