import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class AddFriendDialog extends StatefulWidget {
  const AddFriendDialog({super.key});

  @override
  State<AddFriendDialog> createState() => _AddFriendDialogState();
}

class _AddFriendDialogState extends State<AddFriendDialog> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _friendsNickname = TextEditingController();

  @override
  void dispose() {
    _friendsNickname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context);
    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_add_alt_1_rounded),
          SizedBox(width: 5),
          Text('Añadir amigo'),
        ],
      ),
      actions: [
        CustomFilledButton(
          size: size.width * 0.3,
          text: 'Cancelar',
          color: colors.colorScheme.error,
          height: 35,
          onTap: () {
            context.pop();
          },
        ),
        CustomFilledButton(
          // isLoading: isLoading,
          size: size.width * 0.3,
          height: 35,
          text: '+ Añadir',
          onTap: () {
            _addFriend();
          },
        ),
      ],
      content: SizedBox(
        height: 120,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Escribe el nickname de tu amigo:'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    child: CustomInput(
                      controller: _friendsNickname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa el nickname';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _addFriend() {
    if(_formKey.currentState!.validate()){

    }
  }
}
