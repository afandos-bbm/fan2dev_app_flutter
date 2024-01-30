import 'package:fan2dev/features/projects/cubit/projects_cubit/projects_cubit.dart';
import 'package:fan2dev/features/projects/view/widgets/projects_project_item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsHomePage extends StatelessWidget {
  const ProjectsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectsCubit()..getProjects(),
      child: const ProjectsHomePageView(),
    );
  }
}

class ProjectsHomePageView extends StatelessWidget {
  const ProjectsHomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsCubit, ProjectsCubitState>(
      builder: (context, state) {
        if (state.status == ProjectsCubitStatus.initial) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.error,
                  size: 50,
                ),
                const SizedBox(height: 10),
                Text(
                  'Something went wrong. \nPlease try again. \n${state.error}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context.read<ProjectsCubit>().getProjects();
                  },
                ),
              ],
            ),
          );
        }
        if (state.status == ProjectsCubitStatus.loading ||
            state.status == ProjectsCubitStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      'Welcome to my projects.',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Here you can find some of my projects. I hope you like them. If you have any questions, please contact me.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.projects.length,
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                itemBuilder: (context, index) {
                  return ProjectsProjectItemCardWidget(
                    project: state.projects[index],
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        );
      },
    );
  }
}
