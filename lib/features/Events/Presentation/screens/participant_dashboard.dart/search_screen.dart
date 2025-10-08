import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Events")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search events...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                context.read<EventBloc>().add(SearchEventsEvent(query: value));
              },
            ),
          ),

          Expanded(
            child: BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                if (state is EventLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is EventFetched) {
                  if (state.Events.length == 0) {
                    return const Center(child: Text("No events found"));
                  }

                  return ListView.builder(
                    itemCount: state.Events.length,
                    itemBuilder: (context, index) {
                      final event = state.Events[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: ListTile(
                          title: Text(event.name),
                          subtitle: Text(event.venue),
                          trailing: Text(event.date ?? ""),
                        ),
                      );
                    },
                  );
                }

                if (state is EventError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
